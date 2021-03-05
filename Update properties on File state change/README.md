# Update Properties on File state change

## Event Description
Automatically updates file properties on a file state change.
This sample requires the Vault User Defined Properties (UDPs) "Checked by", "Checked on", "Approved by" and "Approved on" to be present in Vault.

This sample is a good example to explain the PreUpdate and PostUpdate actions, that are needed to trigger the job when the state allows permission to modify the file.
So, of course, a job cannot modify a file if no permission for modification is there.

The **Initial** state is represented by `$file._State`.  
The **Target** state is represented by `$file._NewState`. 

The function ***PreUpdateFileStates*** is used when there **is write permission** in the **Initial** state.  
* When the file is set from state "For Review" to "Work in Progress", the UDPs "Checked by" and "Checked on" get filled.  
* When the file is set from state "Released" to "For Review", the UDPs "Approved by" and "Approved on" get filled.


The function ***PostUpdateFileStates*** is used when there **is no write permission** in the **Initial** state, but in the **Target** state.  
The  4 UDPs are are emptied in the function ***PostUpdateFileStates*** after the file was set from state "Released" to "Work in Progress".

The sample uses the file category name "Drawing Inventor" as a 'condition'. Other categories as well as other objects like file extesnsions can be used as a 'condition'.

## Installation
Download all files (Events and Modules) from the current subdirectory of this repository to your powerEvents directory: *C:\ProgramData\coolOrange\powerEvents*

## At your own risk
The usage of these samples is at your own risk. There is no free support related to the samples. However, if you have questions to powerEvents, then visit http://www.coolorange.com/wiki or start a conversation in our support forum at http://support.coolorange.com/support/discussions

![coolOrange](https://i.ibb.co/NmnmjDT/Logo-CO-Full-colore-RGB-short-Payoff.png)
