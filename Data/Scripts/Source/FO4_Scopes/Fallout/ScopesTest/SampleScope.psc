Scriptname Fallout:ScopesTest::SampleScope extends Quest
import Fallout
import Fallout:Scopes:Menu
import Fallout:Scopes:Papyrus

Actor Player
Scopes:Menu ScopeMenu

; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	OnGameReload()
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
EndEvent


Event Actor.OnPlayerLoadGame(Actor akSender)
	UnregisterForAllEvents()
	OnGameReload()
EndEvent


Function OnGameReload()
	ScopeMenu = ScopeMenu()
	If (ScopeMenu)
		ScopeMenu.RegisterForBreathEvent(self)
		WriteLine(self, "Initialized")
	Else
		RegisterForRemoteEvent(Player, "OnPlayerLoadGame")
		Debug.Trace(self+" Scope framework is unavailable.")
	EndIf
EndFunction


Event Fallout:Scopes:Menu.BreathEvent(Scopes:Menu sender, var[] arguments)
	BreathEventArgs e = sender.GetBreathEventArgs(arguments)
	If (sender.Equipped == Revolver44)
		If (e.Breath == sender.Invalid)
			WriteLine(self, "Fallout:Scopes:Menu.BreathEvent : Invalid")
			return
		ElseIf (e.Breath == sender.BreathHeld)
			UI.Invoke(sender.Name, sender.GetMemberCustom("Steady"))
		ElseIf (e.Breath == sender.BreathReleased)
			UI.Invoke(sender.Name, sender.GetMemberCustom("Unsteady"))
		ElseIf (e.Breath == sender.BreathInterrupted)
			UI.Invoke(sender.Name, sender.GetMemberCustom("Unsteady"))
		Else
			WriteLine(self, "Fallout:Scopes:Menu.BreathEvent : e.Breath : Unhandled Arguments "+e.Breath)
		EndIf
	Else
		WriteLine(self, "Fallout:Scopes:Menu.BreathEvent : Event arguments are none.")
	EndIf
EndEvent

; Properties
;---------------------------------------------

Group Properties
	Weapon Property Revolver44 Auto Const Mandatory
	{A .44 caliber revolver.}
EndGroup
