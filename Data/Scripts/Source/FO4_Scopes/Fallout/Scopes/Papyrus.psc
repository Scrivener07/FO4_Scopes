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


; Debug
;---------------------------------------------

bool Function TraceKeywords(Form aForm) Global DebugOnly
	string logPrefix = "[Papyrus.psc TraceKeywords]" const

	If (aForm)
		Keyword[] array = aForm.GetKeywords()
		If (array)
			int index = 0
			While (index < array.Length)
				WriteLine(logPrefix, aForm+" has keyword: "+array[index]+", @"+index)
				index += 1
			EndWhile
			return true
		Else
			WriteLine(logPrefix, aForm+" has no keywords.")
			return false
		EndIf
	Else
		WriteLine(logPrefix, "Cannot trace keywords on none form.")
		return false
	EndIf
EndFunction


bool Function TracePropertyModifiers(ObjectMod aObjectMod) Global DebugOnly
	string logPrefix = "[Papyrus.psc TracePropertyModifiers]" const

	If (aObjectMod)
		ObjectMod:PropertyModifier[] array = aObjectMod.GetPropertyModifiers()
		If (array)
			int index = 0
			While (index < array.Length)
				WriteLine(logPrefix, aObjectMod+" has PropertyModifier: "+array[index]+", @"+index)
				index += 1
			EndWhile
			return true
		Else
			WriteLine(logPrefix, aObjectMod+" has no property modifiers.")
			return false
		EndIf
	Else
		WriteLine(logPrefix, "Cannot trace property modifiers on none ObjectMod.")
		return false
	EndIf
EndFunction
