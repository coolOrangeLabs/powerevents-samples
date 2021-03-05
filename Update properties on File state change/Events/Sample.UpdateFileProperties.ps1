#=============================================================================#
# PowerShell script sample for COOLORANGE powerEvents                         #
# Copyright (c) COOLORANGE s.r.l. - All rights reserved.                      #
#                                                                             #
# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER   #
# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.  #
#=============================================================================#

Register-VaultEvent -EventName UpdateFileStates_Pre -Action 'PreUpdateFileStates'
Register-VaultEvent -EventName UpdateFileStates_Post -Action 'PostUpdateFileStates'

function PreUpdateFileStates($files) {
    foreach ($file in $files) {
        if ($file._CategoryName -eq "Drawing Inventor" -and $file._NewState -eq "For Review" -and $file._State -eq "Work in Progress") {
            Update-VaultFile -File $file._FullPath -Properties @{
                "Checked by"  = $vaultConnection.UserName; 
                "Checked on" = [System.DateTime]::Now
            }
        }

        if ($file._CategoryName -eq "Drawing Inventor" -and $file._NewState -eq "Released" -and $file._State -eq "For Review") {
            Update-VaultFile -File $file._FullPath -Properties @{
                "Approved by"  = $vaultConnection.UserName; 
                "Approved on" = [System.DateTime]::Now
            }
        }
    }
}
 
function PostUpdateFileStates($files, $successful) {
    foreach ($file in $files) {
        if ($file._CategoryName -eq "Drawing Inventor" -and $file._OldState -eq "Released" -and $file._State -eq "Work in Progress") {
            Update-VaultFile -File $file._FullPath -Properties @{
                "Checked by"  = ""; 
                "Checked on" = $null
                "Approved by"  = ""; 
                "Approved on" = $null
            }
        }
    }
}
