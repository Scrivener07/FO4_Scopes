Scriptname Fallout:Scopes:Framework extends Quest
import Fallout
import Fallout:Scopes:Menu
import Fallout:Scopes:Papyrus


Scopes:Menu ScopeMenu

Actor Player
int BipedWeapon = 41 Const


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	ScopeMenu = GetMenu()
	RegisterForMenuOpenCloseEvent(ScopeMenu.Name)
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening)
		ObjectMod[] array = Player.GetWornItemMods(BipedWeapon)
		If (array)
			int index = 0
			While (index < array.Length)
				ObjectMod omod = array[index]
				ObjectMod:PropertyModifier[] properties = omod.GetPropertyModifiers()

				If (omod.HasWorldModel() && properties.FindStruct("object", HasScope) > -1)
					string modelPath = omod.GetWorldModelPath()
					string filepath = ScopeMenu.PathConvert(modelPath, "swf")
					ScopeMenu.SetCustom(filepath)
					return
				EndIf

				index += 1
			EndWhile
		EndIf
	EndIf
EndEvent


; Globals
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
EndGroup
