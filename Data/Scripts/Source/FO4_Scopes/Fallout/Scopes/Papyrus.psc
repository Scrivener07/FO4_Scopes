ScriptName Fallout:Scopes:Papyrus Const Native Hidden
{Extensions for scripting with Papyrus in general.}


; Logging
;---------------------------------------------

Function Trace(string prefix, string text) Global DebugOnly
	text = prefix + " " + text
 	Debug.Trace(text)
EndFunction


bool Function WriteLine(string prefix, string text) Global DebugOnly
	string filename = "Scopes" const
	text = prefix + " " + text
	If(Debug.TraceUser(filename, text))
		return true
	Else
		Debug.OpenUserLog(filename)
		return Debug.TraceUser(filename, text)
	EndIf
EndFunction


bool Function WriteNotification(string prefix, string text) Global DebugOnly
	Debug.Notification(text)
	return WriteLine(prefix, text)
EndFunction


bool Function WriteMessage(string prefix, string text) Global DebugOnly
	string title
	If (prefix)
		title = prefix+"\n"
	EndIf

	Debug.MessageBox(title+text)
	return WriteLine(prefix, text)
EndFunction
