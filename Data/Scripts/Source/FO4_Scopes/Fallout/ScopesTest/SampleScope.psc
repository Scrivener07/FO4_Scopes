Scriptname Fallout:ScopesTest:SampleScope extends Quest
import Fallout
import Fallout:Scopes
import Fallout:Scopes:Client
import Fallout:Scopes:Menu
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
	Client.RegisterForBreathEvent(self)
	WriteLine(self, "Initialized")
EndFunction


Event Fallout:Scopes:Client.BreathEvent(Scopes:Client sender, var[] arguments)
	BreathEventArgs e = sender.GetBreathEventArgs(arguments)
	If (Framework.Equipped == Revolver44)
		If (e.Breath == sender.Invalid)
			WriteLine(self, "Fallout:Scopes:Client.BreathEvent", "Invalid")
			return
		ElseIf (e.Breath == Framework.BreathHeld)
			UI.Invoke(Menu.Name, Menu.GetMemberCustom("Steady"))
		ElseIf (e.Breath == Framework.BreathReleased)
			UI.Invoke(Menu.Name, Menu.GetMemberCustom("Unsteady"))
		ElseIf (e.Breath == Framework.BreathInterrupted)
			UI.Invoke(Menu.Name, Menu.GetMemberCustom("Unsteady"))
		Else
			WriteUnexpectedValue(self, "Fallout:Scopes:Client.BreathEvent", "e.Breath", "Unhandled Arguments "+e.Breath)
		EndIf
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Scopes:Framework Property Framework Auto Const Mandatory
	Scopes:Menu Property Menu Auto Const Mandatory
	Scopes:Client Property Client Auto Const Mandatory
	Weapon Property Revolver44 Auto Const Mandatory
	{A .44 caliber revolver.}
EndGroup
