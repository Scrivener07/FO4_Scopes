Scriptname Fallout:Scopes:Client extends Fallout:Scopes:Type
{The client API for scope overlay interactions.}
import Fallout
import Fallout:Scopes
import Fallout:Scopes:Papyrus

Actor Player


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
EndEvent


; Methods
;---------------------------------------------

string Function GetMember(string member)
	{Provides the instance member's variable path for the loaded client.}
	If (member)
		return Menu.GetClient()+"."+member
	Else
		WriteUnexpectedValue(self, "GetMember", "member", "The value cannot be none or empty.")
		return ""
	EndIf
EndFunction


var Function Get(string member)
	{Gets a client property member value. The return type must be cast.}
	return UI.Get(Menu.Name, GetMember(member))
EndFunction


bool Function Set(string member, var argument)
	{Sets a client property member with the given argument.}
	return UI.Set(Menu.Name, GetMember(member), argument)
EndFunction


var Function Invoke(string member, var[] arguments = none)
	{Invokes a client function member with the given arguments.}
	return UI.Invoke(Menu.Name, GetMember(member), arguments)
EndFunction


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
	Scopes:Menu Property Menu Auto Const Mandatory
EndGroup

Group Framework
	Weapon Property Equipped Hidden
		Weapon Function Get()
			return Player.GetEquippedWeapon()
		EndFunction
	EndProperty
EndGroup
