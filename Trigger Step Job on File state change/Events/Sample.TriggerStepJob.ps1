#=============================================================================#
# PowerShell script sample for COOLORANGE powerEvents                         #
# Copyright (c) COOLORANGE s.r.l. - All rights reserved.                      #
#                                                                             #
# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER   #
# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.  #
#=============================================================================#

Register-VaultEvent -EventName UpdateFileStates_Post -Action 'PostUpdateFileStates'

function PostUpdateFileStates($files, $successful) {
    if(-not $successful) { return }

    $releasedFiles = @($files | Where-Object { @("ipt", "iam") -contains $_._Extension -and $_._ReleasedRevision -eq $true })
    foreach($file in $releasedFiles) {
        Add-VaultJob -Name "Sample.CreateSTEP" -Parameters @{ "EntityId"=$file.Id; "EntityClassId"="FILE" } -Description "Create STEP for file '$($file._Name)'"
    }
}