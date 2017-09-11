Scriptname Fallout:Scopes:Menu extends Quest
import Fallout

; Functions
;---------------------------------------------

Function SetOverlay(int identifier)
	var[] arguments = new var[1]
	arguments[0] = identifier
	UI.Invoke(Name, GetMember("SetOverlay"), arguments)
EndFunction


Function SetCustom(string filePath)
	; directory rooted `Data/Interface`
	var[] arguments = new var[1]
	arguments[0] = filePath
	UI.Invoke(Name, GetMember("SetCustom"), arguments)
EndFunction


string Function GetMember(string member)
	return Instance+"."+member
EndFunction


Menu Function ScopeMenu() Global
	return Game.GetFormFromFile(0x01000F99, "Scopes.esp") as Menu
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
	int Property ScopeDefault = 0 AutoReadOnly
	int Property ScopeFine = 1 AutoReadOnly
	int Property ScopeDuplex = 2 AutoReadOnly
	int Property ScopeGerman = 3 AutoReadOnly
	int Property ScopeDot = 4 AutoReadOnly
	int Property ScopeMilDot = 5 AutoReadOnly
	int Property ScopeCircle = 6 AutoReadOnly
	int Property ScopeOldRangefind = 7 AutoReadOnly
	int Property ScopeModernRangefind = 8 AutoReadOnly
	int Property ScopeSVD = 9 AutoReadOnly
	int Property ScopeHandPainted = 10 AutoReadOnly
	int Property ScopeBinoculars = 11 AutoReadOnly
	int Property ScopeM14NightVision = 12 AutoReadOnly
	int Property Scope00 = 13 AutoReadOnly
	int Property ScopeInternalRangefinder = 14 AutoReadOnly
	int Property ScopeRangefinder00 = 15 AutoReadOnly
	int Property ScopeAssaultRifle_REC = 16 AutoReadOnly
EndGroup
