Scriptname Fallout:Scopes:SampleScope extends Quest Default
import Fallout
import Fallout:Scopes:Menu

Actor Player
Scopes:Menu ScopeMenu
int AltLeft = 164 const


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	ScopeMenu = ScopeMenu()
	RegisterForMenuOpenCloseEvent(ScopeMenu.Name)
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening)
		If (Player.GetEquippedWeapon() == WeaponType)
			ScopeMenu.SetCustom(FilePath)
			RegisterForKey(AltLeft)
		EndIf
	Else
		UnregisterForKey(AltLeft)
	EndIf
EndEvent


Event OnKeyDown(int keyCode)
	Steady()
EndEvent


Event OnKeyUp(int keyCode, float time)
	Unsteady()
EndEvent


; Functions
;---------------------------------------------

Function Steady()
	UI.Invoke(ScopeMenu.Name, ScopeMenu.GetMember("OverlayLoader_mc.instance5.Steady"))
	Debug.Notification("Scope Steady")
EndFunction


Function Unsteady()
	UI.Invoke(ScopeMenu.Name, ScopeMenu.GetMember("OverlayLoader_mc.instance5.Unsteady"))
	Debug.Notification("Scope Unsteady")
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Weapon Property WeaponType Auto Const Mandatory
	string Property FilePath Auto Const Mandatory
EndGroup
