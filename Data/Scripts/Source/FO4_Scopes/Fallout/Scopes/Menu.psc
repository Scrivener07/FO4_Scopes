Scriptname Fallout:Scopes:Menu extends Quest
import Fallout
import Fallout:Scopes:Papyrus


; Methods
;---------------------------------------------

Function SetOverlay(int identifier)
	var[] arguments = new var[1]
	arguments[0] = identifier
	UI.Invoke(Name, GetMember("SetOverlay"), arguments)
	WriteLine(self, "SetOverlay:"+identifier)
EndFunction


Function SetCustom(string filePath)
	var[] arguments = new var[1]
	arguments[0] = filePath
	UI.Invoke(Name, GetMember("SetCustom"), arguments)
	WriteLine(self, "SetCustom:"+filePath)
EndFunction


string Function GetCustom()
	string value = UI.Invoke(Name, GetMember("GetCustom"))
	WriteLine(self, "GetCustom:"+value)
	return value
EndFunction


string Function PathConvert(string filePath, string toExtension)
	var[] arguments = new var[2]
	arguments[0] = filePath
	arguments[1] = toExtension
	string value = UI.Invoke(Name, GetMember("PathConvert"), arguments) as string
	WriteLine(self, "PathConvert From["+filePath+"], To["+value+"]")
	return value
EndFunction


; Functions
;---------------------------------------------

string Function GetMember(string member)
	return Instance+"."+member
EndFunction

string Function GetMemberCustom(string member)
	return Custom+"."+member
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
	string Property Custom Hidden
		string Function Get()
			return GetCustom()
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
EndGroup

Group Keyboard
	int Property HoldBreath = 164 AutoReadOnly
EndGroup
