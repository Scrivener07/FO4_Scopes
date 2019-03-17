Scriptname Fallout:Scopes:Menu extends Quest
import Fallout
import Fallout:Scopes:Papyrus

; Methods
;---------------------------------------------

string Function ConvertFileExtension(string filePath, string extension)
	If (filePath)
		If (extension)
			var[] arguments = new var[2]
			arguments[0] = filePath
			arguments[1] = extension
			return UI.Invoke(Name, GetMember("ConvertFileExtension"), arguments)
		Else
			WriteLine(self, "ConvertFileExtension: Argument `extension` cannot be none or empty.")
			return none
		EndIf
	Else
		WriteLine(self, "ConvertFileExtension: Argument `filePath` cannot be none or empty.")
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
	If (identifier >= Default && identifier <= Empty)
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
			WriteLine(self, "GetMemberCustom : custom : Could not get an instance for the "+member+" member.")
			return none
		EndIf
	Else
		WriteLine(self, "GetMemberCustom : member : Argument cannot be none or empty.")
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	; Scopes:Client Property Client Auto Const Mandatory

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

	bool Property IsOpen Hidden
		bool Function Get()
			return UI.IsMenuOpen(Name)
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
	int Property SolarCannon = 19 AutoReadOnly
	int Property SolarCannonNight = 20 AutoReadOnly
	int Property Empty = 21 AutoReadOnly
EndGroup
