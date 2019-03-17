Scriptname Fallout:Scopes:Client extends Fallout:Scopes:Type
import Fallout
import Fallout:Scopes
import Fallout:Scopes:Papyrus


; Open/Close Event
;---------------------------------------------

CustomEvent OpenCloseEvent

Struct OpenCloseEventArgs
	bool Opening = false
EndStruct


bool Function RegisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForOpenCloseEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForOpenCloseEvent", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction


OpenCloseEventArgs Function GetOpenCloseEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as OpenCloseEventArgs
	Else
		return none
	EndIf
EndFunction


; Breath Event
;---------------------------------------------

CustomEvent BreathEvent

Struct BreathEventArgs
	int Breath = -1
EndStruct


bool Function RegisterForBreathEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "BreathEvent")
		return true
	Else
		WriteUnexpectedValue(self, "RegisterForBreathEvent", "script", "Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForBreathEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "BreathEvent")
		return true
	Else
		WriteUnexpectedValue(self, "UnregisterForBreathEvent", "script", "Cannot unregister a none script for events.")
		return false
	EndIf
EndFunction

BreathEventArgs Function GetBreathEventArgs(var[] arguments)
	If (arguments)
		return arguments[0] as BreathEventArgs
	Else
		return none
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Scopes:Framework Property Framework Auto Const Mandatory
EndGroup
