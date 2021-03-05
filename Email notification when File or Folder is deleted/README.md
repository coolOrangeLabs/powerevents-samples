# Email notification when file or folder is deleted

## Event Description
Sends an email notification when a file or a folder is deleted.

In the header of the ps1 file some settings need to be done, that the email can be send.  
* **$emailTo**: Mail address or alias to whom the mail should be send.   
* **$emailFrom**: Mail address of the sender and display name of sender
* **$emailSmtp**: SMTP SERVER name
* **$emailPort**: Port for SMTP SERVER, default 587
* **$emailUser**: User name for eamil account; in most cases the email address
* **$emailPwd**: Password for eamil account

In the variable ***$body*** the email text is contained.

## Installation
Download all files (Events and Modules) from the current subdirectory of this repository to your powerEvents directory: *C:\ProgramData\coolOrange\powerEvents*

## At your own risk
The usage of these samples is at your own risk. There is no free support related to the samples. However, if you have questions to powerEvents, then visit http://www.coolorange.com/wiki or start a conversation in our support forum at http://support.coolorange.com/support/discussions

![coolOrange](https://user-images.githubusercontent.com/36075173/46519882-4b518880-c87a-11e8-8dab-dffe826a9630.png)
