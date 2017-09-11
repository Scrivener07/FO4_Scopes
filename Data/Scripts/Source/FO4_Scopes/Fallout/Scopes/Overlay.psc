Scriptname Fallout:Scopes:Overlay extends Quest Default
import Fallout
import Fallout:Scopes:Menu

Actor Player
Scopes:Menu Menu


; Events
;---------------------------------------------

Event OnInit()
	Player = Game.GetPlayer()
	Menu = ScopeMenu()
	RegisterForMenuOpenCloseEvent(Menu.Name)
EndEvent


Event OnMenuOpenCloseEvent(string asMenuName, bool abOpening)
	If (abOpening)
		If (Player.GetEquippedWeapon() == WeaponType)
			Menu.SetCustom(FilePath)
			Debug.Notification("Loaded:"+FilePath)
		EndIf
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Weapon Property WeaponType Auto Const Mandatory
	string Property FilePath Auto Const Mandatory
EndGroup
