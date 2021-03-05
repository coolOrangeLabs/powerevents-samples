#=============================================================================#
# PowerShell script sample for COOLORANGE powerEvents                         #
# Copyright (c) COOLORANGE s.r.l. - All rights reserved.                      #
#                                                                             #
# THIS SCRIPT/CODE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER   #
# EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES #
# OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT.  #
#=============================================================================#

Register-VaultEvent -EventName UpdateItemStates_Restrictions -Action 'RestrictUpdateItemStates'
function RestrictUpdateItemStates($items) {
	foreach ($item in $items) {
		$bomRows = Get-VaultItemBom -Number $item._Number
		foreach ($bomRow in $bomRows) {
			if (-not $bomRow.Bom_PositionNumber) {
				Add-VaultRestriction -EntityName "$($item._Number): $($bomRow.Bom_Number)" -Message "Position of row '$($bomRow.Bom_Number)' is empty!"
			}
		}
	}
}