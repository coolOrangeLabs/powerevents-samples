# Restrict File State change when Job is in Queue

## Event Description
Restricts a file lifecycle state change as long as there are jobs in the queue for this particalar file. This can be used to avoid non-tip version errors in jobs on the Vault Job Processor. A file that is about to be executed by the Job Processor (e.g. to create a PDF file) must not get a new file version due to a file lifecycle state change.

## Installation
Download all files (Events and Modules) from the current subdirectory of this repository to your powerEvents directory: *C:\ProgramData\coolOrange\powerEvents*

## At your own risk
The usage of these samples is at your own risk. There is no free support related to the samples. However, if you have questions to powerEvents, then visit http://www.coolorange.com/wiki or start a conversation in our support forum at http://support.coolorange.com/support/discussions

![coolOrange](https://i.ibb.co/NmnmjDT/Logo-CO-Full-colore-RGB-short-Payoff.png)
