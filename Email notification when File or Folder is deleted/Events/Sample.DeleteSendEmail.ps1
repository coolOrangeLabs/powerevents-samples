#=============================================================================#
# PowerShell script sample for COOLORANGE powerEvents                         #
# Copyright (c) COOLORANGE s.r.l. - All rights reserved.                      #
#                                                                             #
# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER   #
# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.  #
#=============================================================================#

$emailTo    = @("administrator@yourcompany.com")
$emailFrom  = New-Object System.Net.Mail.MailAddress("jobserver@yourcompany.com", "coolOrange powerJobs")
$emailSmtp  = "<SMTP_SERVER>"
$emailPort  = 587
$emailUser  = "<USER>"
$emailPwd   = "<PASSWORD>"

function Send-Email($subject, $body) {
    $password = ConvertTo-SecureString -AsPlainText $emailPwd -Force
    $cred = New-Object Management.Automation.PSCredential $emailUser, $password

    foreach($email in $emailTo) {
        Send-MailMessage -From $emailFrom -To $email -Subject $subject -BodyAsHtml $body -SmtpServer $emailSmtp -Credential $cred -Port $emailPort -UseSsl
    }
}

Register-VaultEvent -EventName DeleteFiles_Post -Action 'PostDeleteFiles'
Register-VaultEvent -EventName DeleteFolder_Post -Action 'PostDeleteFolder'

function PostDeleteFiles($deletedFiles, $successful) {
    if(-not $successful) { return }

    $subject = "A file has been deleted in Vault"
    $body = "<p>The user '$($vaultConnection.UserName)' deleted the file: <br>$($deletedFiles._FullPath)</p>"
    Send-Email $subject $body
}

function PostDeleteFolder($deletedFolder, $successful) {
    if(-not $successful) { return }

    $subject = "A folder has been deleted in Vault"
    $body = "<p>The user '$($vaultConnection.UserName)' deleted the folder: <br>$($deletedFolder._FullPath)</p>"
    Send-Email $subject $body
}
