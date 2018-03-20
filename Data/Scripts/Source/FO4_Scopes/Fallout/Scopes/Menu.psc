Scriptname Fallout:Scopes:Menu extends Quest
import Fallout
import Fallout:Scopes:Papyrus


Actor Player
string ModelPath

int BipedWeapon = 41 Const


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	RegisterForRemoteEvent(Player, "OnPlayerModArmorWeapon")
	RegisterForMenuOpenCloseEvent(Name)
EndEvent


Event Actor.OnItemEquipped(Actor akSender, Form akBaseObject, ObjectReference akReference)
	If (akBaseObject is Weapon)
		ModelPath = GetModelPath()
	EndIf
EndEvent


Event Actor.OnPlayerModArmorWeapon(Actor akSender, Form akBaseObject, ObjectMod akModBaseObject)
	If (akBaseObject is Weapon)
		ModelPath = GetModelPath()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening)
		string overlay = ConvertFileExtension(ModelPath, "swf")
		WriteLine(self, "OnMenuOpenCloseEvent: The converted overlay path is "+overlay)
		SetCustom(overlay)
	EndIf
EndEvent


; Methods
;---------------------------------------------

string Function GetModelPath()
	ObjectMod[] array = Player.GetWornItemMods(BipedWeapon)
	If (array)
		int index = 0
		While (index < array.Length)
			ObjectMod omod = array[index]
			ObjectMod:PropertyModifier[] properties = omod.GetPropertyModifiers()
			If (omod.HasWorldModel() && properties.FindStruct("object", HasScope) > -1)
				return omod.GetWorldModelPath()
			EndIf
			index += 1
		EndWhile
		return none
	EndIf
EndFunction


string Function ConvertFileExtension(string filePath, string toExtension)
	If (filePath)
		If (toExtension)
			var[] arguments = new var[2]
			arguments[0] = filePath
			arguments[1] = toExtension
			return UI.Invoke(Name, GetMember("ConvertFileExtension"), arguments)
		Else
			WriteLine(self, "ConvertFileExtension: Argument toExtension cannot be none or empty.")
			return none
		EndIf
	Else
		WriteLine(self, "ConvertFileExtension: Argument filePath cannot be none or empty.")
		return none
	EndIf
EndFunction


Function SetCustom(string filePath)
	If (filePath)
		var[] arguments = new var[1]
		arguments[0] = filePath
		UI.Invoke(Name, GetMember("SetCustom"), arguments)
		WriteLine(self, "SetCustom:"+filePath)
	Else
		WriteLine(self, "SetCustom: Argument filePath cannot be none or empty.")
	EndIf
EndFunction


Function SetOverlay(int identifier)
	If (identifier >= 0 && identifier <= 16)
		var[] arguments = new var[1]
		arguments[0] = identifier
		UI.Invoke(Name, GetMember("SetOverlay"), arguments)
		WriteLine(self, "SetOverlay:"+identifier)
	Else
		WriteLine(self, "SetOverlay: Argument "+identifier+" is out of range.")
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function GetMember(string member)
	If (member)
		return Instance+"."+member
	Else
		WriteLine(self, "GetMember: Argument member cannot be none or empty.")
		return none
	EndIf
EndFunction


string Function GetMemberCustom(string member)
	If (member)
		string custom = UI.Invoke(Name, GetMember("GetCustom"))
		If (custom)
			return custom+"."+member
		Else
			WriteLine(self, "GetMemberCustom: Could not get an instance for the "+member+" member.")
			return none
		EndIf
	Else
		WriteLine(self, "GetMemberCustom: Argument member cannot be none or empty.")
		return none
	EndIf
EndFunction


; Globals
;---------------------------------------------

Scopes:Menu Function ScopeMenu() Global
	return Game.GetFormFromFile(0x01000F99, "Scopes.esp") as Scopes:Menu
EndFunction


; Properties
;---------------------------------------------

Group Properties
	string Property Name Hidden
		string Function Get()
			return "ScopeMenu"
		EndFunction
	EndProperty
	string Property Instance Hidden
		string Function Get()
			return "root1.ScopeMenuInstance"
		EndFunction
	EndProperty
EndGroup

Group Identifiers
	int Property Default = 0 AutoReadOnly
	int Property Fine = 1 AutoReadOnly
	int Property Duplex = 2 AutoReadOnly
	int Property German = 3 AutoReadOnly
	int Property Dot = 4 AutoReadOnly
	int Property MilDot = 5 AutoReadOnly
	int Property Circle = 6 AutoReadOnly
	int Property OldRangefind = 7 AutoReadOnly
	int Property ModernRangefind = 8 AutoReadOnly
	int Property SVD = 9 AutoReadOnly
	int Property HandPainted = 10 AutoReadOnly
	int Property Binoculars = 11 AutoReadOnly
	int Property M14NightVision = 12 AutoReadOnly
	int Property Zero = 13 AutoReadOnly
	int Property InternalRangefinder = 14 AutoReadOnly
	int Property Rangefinder00 = 15 AutoReadOnly
	int Property AssaultRifle_REC = 16 AutoReadOnly
	int Property GaussRiflePrototypeA = 17 AutoReadOnly
	int Property GaussRiflePrototypeB = 18 AutoReadOnly
	int Property Empty = 19 AutoReadOnly
EndGroup

Group Keyboard
	int Property HoldBreath = 164 AutoReadOnly
EndGroup

Group Keywords
	Keyword Property HasScope Auto Const Mandatory
	{The keyword an OMOD must add via its property modifiers.}
EndGroup
