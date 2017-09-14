Scriptname Fallout:Scopes:Framework extends Quest
import Fallout
import Fallout:Scopes:Menu
import Fallout:Scopes:Papyrus

Actor Player
int WeaponIndex = 41 Const

; * Weapon Attach Point == 'ap_gun_Scope' on scope mods.
; ** Still might be an iron sight with attach point only..

; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
EndEvent


; Functions
;---------------------------------------------

String Function GetModelPath()
	ObjectMod[] array = Player.GetWornItemMods(WeaponIndex)
	int index = 0

	string result ; return last for now...
	While (index < array.length)
		ObjectMod value = array[index]
		result = value.GetWorldModelPath()
		WriteLine(self, "Found the object mod '"+value+"' on slot index "+WeaponIndex+" with result " +result+", @"+index)

		If (index == 2) ; faking it for .44 pistol
			return result
		Else
			index += 1
		EndIf
	EndWhile
	return result ; TODO: select the correct return result from array.
EndFunction


bool Function HasScope(Weapon akWeapon)
	return akWeapon.HasKeyword(HasScope)
EndFunction


; Framework
;---------------------------------------------

Scopes:Framework Function GetFramework() Global
	return Game.GetFormFromFile(0x01000F99, "Scopes.esp") as Scopes:Framework
EndFunction


Scopes:Menu Function GetMenu() Global
	return Game.GetFormFromFile(0x01000F99, "Scopes.esp") as Scopes:Menu
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Keyword Property HasScope Auto Const Mandatory
	Keyword Property Fallout_Scopes_Keyword Auto Const Mandatory
EndGroup
