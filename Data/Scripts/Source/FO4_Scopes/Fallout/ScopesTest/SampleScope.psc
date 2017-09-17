Scriptname Fallout:ScopesTest:SampleScope extends Quest Default
import Fallout
import Fallout:Scopes:Framework
import Fallout:Scopes:Papyrus

Actor Player
Scopes:Menu ScopeMenu


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	TryFramework()
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	TryFramework()
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (Player.GetEquippedWeapon() == Revolver44)
		If (abOpening)
			RegisterForKey(ScopeMenu.HoldBreath)
		Else
			UnregisterForKey(ScopeMenu.HoldBreath)
		EndIf
	EndIf
EndEvent


Event OnKeyDown(int keyCode)
	UI.Invoke(ScopeMenu.Name, ScopeMenu.GetMemberCustom("Steady"))
	WriteLine(self, "Steady")
EndEvent


Event OnKeyUp(int keyCode, float time)
	UI.Invoke(ScopeMenu.Name, ScopeMenu.GetMemberCustom("Unsteady"))
	WriteLine(self, "Unsteady")
EndEvent


; Properties
;---------------------------------------------

bool Function TryFramework()
	ScopeMenu = GetMenu()
	If (ScopeMenu)
		UnregisterForRemoteEvent(Player, "OnPlayerLoadGame")
		RegisterForMenuOpenCloseEvent(ScopeMenu.Name)
		WriteLine(self, "Initialized")
		return true
	Else
		RegisterForRemoteEvent(Player, "OnPlayerLoadGame")
		WriteLine(self, "Scope framework is not installed.")
		return false
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Weapon Property Revolver44 Auto Const Mandatory
	{A .44 caliber revolver.}
EndGroup
