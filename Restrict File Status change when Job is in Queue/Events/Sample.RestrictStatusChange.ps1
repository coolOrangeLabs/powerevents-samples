#=============================================================================#
# PowerShell script sample for coolOrange powerEvents                         #
# Restricts a file status change as long as there are jobs in the queue		  #
# for this particalar file											      	  #
#                                                                             #
# Copyright (c) coolOrange s.r.l. - All rights reserved.                      #
#                                                                             #
# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER   #
# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.  #
#=============================================================================#

Register-VaultEvent -EventName UpdateFileStates_Restrictions -Action 'RestrictUpdateFileStates'

function RestrictUpdateFileStates($files) {
    foreach ($file in $files) {
        $jobs = @(GetRelatedJobs -file $file)
        if ($jobs.Count -gt 0) {
            Add-VaultRestriction -EntityName $file.Name -Message "File state can't be changed as long as there are active jobs for this file in the job queue!"
        }
    }
}

function GetRelatedJobs($file) {
	$results = @()

    $files = $vault.DocumentService.GetFilesByMasterId($file.MasterId)
	$fileIds = $files | Select-Object -ExpandProperty Id
	$jobs = $vault.JobService.GetJobsByDate([Int32]::MaxValue, [System.DateTime]::MinValue)
	foreach($job in $jobs) 	{
		$paramEntityClassId = $job.ParamArray | Where-Object { $_.Name -eq "EntityClassId" -and $_.Val -eq "FILE" }
		$paramEntityId = $job.ParamArray | Where-Object { $_.Name -eq "EntityId" -and $fileIds -contains $_.Val }
		$paramFileId = $job.ParamArray | Where-Object { $_.Name -eq "FileId" -and $fileIds -contains $_.Val }
		$paramFileVersionIds = $job.ParamArray | Where-Object { $_.Name -eq "FileVersionIds" -and $fileIds -contains $_.Val }	
		
		if (($paramEntityClassId -and $paramEntityId) -or $paramFileId -or $paramFileVersionIds) {
			$results += $job
		}
	}
	
	return $results
}