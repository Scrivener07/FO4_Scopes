ScriptName Fallout:Scopes:Breath extends ActiveMagicEffect
import Fallout
import Fallout:Scopes:Client

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (Framework.IsBreathKeyDown)
		BreathEventArgs e = new BreathEventArgs
		e.Breath = Framework.BreathInterrupted
		Framework.SendBreathEvent(e)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Scopes:Framework Property Framework Auto Const Mandatory
EndGroup
