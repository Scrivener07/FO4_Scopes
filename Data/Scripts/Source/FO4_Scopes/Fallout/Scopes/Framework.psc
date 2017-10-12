Scriptname Fallout:Scopes:Framework extends Quest
import Fallout
import Fallout:Scopes:Papyrus


Scopes:Menu ScopeMenu

Actor Player
string FilePath

int BipedWeapon = 41 Const


; Events
;---------------------------------------------

Event OnInit()
	ScopeMenu = ScopeMenu()
	Player = Game.GetPlayer()
	RegisterForMenuOpenCloseEvent(ScopeMenu.Name)
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	RegisterForRemoteEvent(Player, "OnPlayerModArmorWeapon")
EndEvent


Event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
	If (akBaseObject is Weapon)
		FilePath = GetFilePath()
	EndIf
EndEvent


Event Actor.OnPlayerModArmorWeapon(Actor akSender, Form akBaseObject, ObjectMod akModBaseObject)
	If (akBaseObject is Weapon)
		FilePath = GetFilePath()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening)
		ScopeMenu.SetCustom(FilePath)
	EndIf
EndEvent


; Methods
;---------------------------------------------

string Function GetFilePath()
	ObjectMod[] array = Player.GetWornItemMods(BipedWeapon)
	If (array)
		int index = 0
		While (index < array.Length)
			ObjectMod omod = array[index]
			ObjectMod:PropertyModifier[] properties = omod.GetPropertyModifiers()
			If (omod.HasWorldModel() && properties.FindStruct("object", HasScope) > -1)
				string modelPath = omod.GetWorldModelPath()
				return ScopeMenu.PathConvert(modelPath, "swf")
			EndIf
			index += 1
		EndWhile
		return none
	EndIf
EndFunction


Scopes:Menu Function ScopeMenu() Global
	return Game.GetFormFromFile(0x01000F99, "Scopes.esp") as Scopes:Menu
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Keyword Property HasScope Auto Const Mandatory
	{The keyword an OMOD must add via its property modifiers.}
EndGroup
