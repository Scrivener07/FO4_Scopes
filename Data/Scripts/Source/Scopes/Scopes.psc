Scriptname Scopes extends Quest


Actor Player
string ScopeMenu = "ScopeMenu" const
string Method = "root.ScopeMenuInstance" const


; The frame labels of scopes in swf file.
int ScopeDefault = 1 const
int ScopeFine = 2 const
int ScopeDuplex = 3 const
int ScopeGerman = 4 const
int ScopeDot = 5 const
int ScopeMilDot = 6 const
int ScopeCircle = 7 const
int ScopeOldRangefind = 8 const
int ScopeModernRangefind = 9 const
int ScopeSVD = 10 const
int ScopeHandPainted = 11 const
int ScopeBinoculars = 12 const
int ScopeM14NightVision = 13 const
int Scope00 = 14 const
int ScopeInternalRangefinder = 15 const
int ScopeRangefinder00 = 16 const
int ScopeAssaultRifle_REC = 17 const


; Events
;---------------------------------------------

Event OnInit()
	RegisterForMenuOpenCloseEvent(ScopeMenu)
	Player = Game.GetPlayer()
	Player.AddItem(LL_44_Pistol_Scoped)
	Player.AddItem(LL_HuntingRifle_Sniper)
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening)
		Utility.Wait(3.0)
		SetOverlay(ScopeSVD)
		Debug.Notification("Set the scope overlay.")
	EndIf
EndEvent


; Functions
;---------------------------------------------

Function SetOverlay(int frameNumber)
		var[] arguments = new var[1]
		arguments[0] = frameNumber
		UI.Invoke(ScopeMenu, GetMember("SetOverlay"), arguments)
EndFunction


string Function GetMember(string member)
	return Method+"."+member
EndFunction


; Properties
;---------------------------------------------

Group Properties
	LeveledItem Property LL_44_Pistol_Scoped Auto Const Mandatory
	LeveledItem Property LL_HuntingRifle_Sniper Auto Const Mandatory
EndGroup
