Scriptname Fallout:Scopes:SampleScope extends Quest Default
import Fallout
import Fallout:Scopes:Framework
import Fallout:Scopes:Papyrus

Actor Player
Scopes:Framework Framework
Scopes:Menu ScopeMenu


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	Framework = GetFramework()
	ScopeMenu = GetMenu()
	RegisterForMenuOpenCloseEvent(ScopeMenu.Name)
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening)
		If (Player.GetEquippedWeapon() == WeaponType)

			string modelPath = Framework.GetModelPath()
			string filepath = ScopeMenu.ConvertPath(modelPath, "swf")

			ScopeMenu.SetCustom(filepath)
			RegisterForKey(ScopeMenu.HoldBreath)
		EndIf
	Else
		UnregisterForKey(ScopeMenu.HoldBreath)
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
	WriteLine(self, "Steady")
EndFunction


Function Unsteady()
	UI.Invoke(ScopeMenu.Name, ScopeMenu.GetMember("OverlayLoader_mc.instance5.Unsteady"))
	WriteLine(self, "Unsteady")
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Weapon Property WeaponType Auto Const Mandatory
EndGroup
