ScriptName Fallout:Scopes:Breath extends ActiveMagicEffect
import Fallout:Scopes:Menu

; Events
;---------------------------------------------

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If (ScopeMenu.IsOpen && ScopeMenu.IsBreathKeyDown)
		BreathEventArgs e = new BreathEventArgs
		e.Breath = ScopeMenu.BreathInterrupted
		ScopeMenu.SendBreathEvent(e)
	EndIf
EndEvent


; Properties
;---------------------------------------------

Group Properties
	Fallout:Scopes:Menu Property ScopeMenu Auto Const Mandatory
EndGroup
