ScriptName Fallout:Scopes:Breath extends ActiveMagicEffect
import Fallout:Scopes:Menu
import Fallout:Scopes:Client

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (Menu.IsOpen && Framework.IsBreathKeyDown)
		BreathEventArgs e = new BreathEventArgs
		e.Breath = Framework.BreathInterrupted
		Framework.SendBreathEvent(e)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Fallout:Scopes:Framework Property Framework Auto Const Mandatory
	Fallout:Scopes:Menu Property Menu Auto Const Mandatory
EndGroup
