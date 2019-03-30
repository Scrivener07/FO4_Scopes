Scriptname Revolver44:Scope extends Quest
import Fallout:Scopes:Client
import Fallout:Scopes:Papyrus

Actor Player

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
	Client.RegisterForOpenCloseEvent(self)
	Client.RegisterForBreathEvent(self)
	WriteLine(self, "Initialized")
EndFunction

Event Fallout:Scopes:Client.OpenCloseEvent(Fallout:Scopes:Client sender, var[] arguments)
	If (Client.Equipped == Revolver44)
		OpenCloseEventArgs e = sender.GetOpenCloseEventArgs(arguments)
		If (e.Opening)
			WriteLine(self, "Fallout:Scopes:Client.OpenCloseEvent", "Opening")
		Else
			WriteLine(self, "Fallout:Scopes:Client.OpenCloseEvent", "Closing")
		EndIf
	EndIf
EndEvent


Event Fallout:Scopes:Client.BreathEvent(Fallout:Scopes:Client sender, var[] arguments)
	If (Client.Equipped == Revolver44)
		BreathEventArgs e = sender.GetBreathEventArgs(arguments)
		If (e.Breath == sender.Invalid)
			WriteLine(self, "Fallout:Scopes:Client.BreathEvent", "Invalid")
			return
		ElseIf (e.Breath == Client.BreathHeld)
			Client.Invoke("Steady")
		ElseIf (e.Breath == Client.BreathReleased)
			Client.Invoke("Unsteady")
		ElseIf (e.Breath == Client.BreathInterrupted)
			Client.Invoke("Unsteady")
		Else
			WriteUnexpectedValue(self, "Fallout:Scopes:Client.BreathEvent", "e.Breath", "Unhandled Arguments "+e.Breath)
		EndIf
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Fallout:Scopes:Client Property Client Auto Const Mandatory
	Weapon Property Revolver44 Auto Const Mandatory
	{A .44 caliber revolver.}
EndGroup
