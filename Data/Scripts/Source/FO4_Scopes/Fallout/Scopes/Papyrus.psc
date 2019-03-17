ScriptName Fallout:Scopes:Papyrus Const Native Hidden
{Extensions for scripting with Papyrus in general.}


; Logging
;---------------------------------------------

bool Function Write(string prefix, string text) Global DebugOnly
	{Writes text as lines in a log file.}
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
	{Writes notifications as lines in a log file.}
	Debug.Notification(text)
	return Write(prefix, text)
EndFunction


bool Function WriteMessage(string prefix, string title, string text = "") Global DebugOnly
	{Writes messages as lines in a log file.}
	string value
	If (text)
		value = title+"\n"+text
	EndIf
	Debug.MessageBox(value)
	return Write(prefix, title+" "+text)
EndFunction


; Debug
;---------------------------------------------

bool Function WriteLine(var script, string member, string text = "") Global DebugOnly
	{Writes script info as lines in a log file.}
	If !(text)
		return Write(script, member)
	Else
		return Write(script+"["+member+"]", text)
	EndIf
EndFunction


bool Function WriteUnexpected(var script, string member, string text = "") Global DebugOnly
	{The script had an unexpected operation.}
	return Write(script+"["+member+"]", "The member '"+member+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteUnexpectedValue(var script, string member, string variable, string text = "") Global DebugOnly
	{The script had and unexpected value.}
	return Write(script+"["+member+"."+variable+"]", "The member '"+member+"' with variable '"+variable+"' had an unexpected operation. "+text)
EndFunction


bool Function WriteNotImplemented(var script, string member, string text = "") Global DebugOnly
	{The exception that is thrown when a requested method or operation is not implemented.}
	; The exception is thrown when a particular method, get accessors, or set accessors is present as a member of a type but is not implemented.
	return Write(script, member+": The member '"+member+"' was not implemented. "+text)
EndFunction


Function WriteChangedValue(var script, string propertyName, var fromValue, var toValue) Global DebugOnly
	{The value has changed from one value to another.}
	WriteLine(script, "Changing '"+propertyName+"' from '"+fromValue+"' to '"+toValue+"'.")
EndFunction


; Debug
;---------------------------------------------

bool Function TraceKeywords(Form aForm) Global DebugOnly
	string prefix = "[Fallout:Scopes:Papyrus.TraceKeywords]" const
	If (aForm)
		Keyword[] array = aForm.GetKeywords()
		If (array)
			int index = 0
			While (index < array.Length)
				WriteLine(prefix, aForm+" has keyword: "+array[index]+", @"+index)
				index += 1
			EndWhile
			return true
		Else
			WriteLine(prefix, aForm+" has no keywords.")
			return false
		EndIf
	Else
		WriteLine(prefix, "Cannot trace keywords on none form.")
		return false
	EndIf
EndFunction


bool Function TracePropertyModifiers(ObjectMod aObjectMod) Global DebugOnly
	string prefix = "[Fallout:Scopes:Papyrus.TracePropertyModifiers]" const
	If (aObjectMod)
		ObjectMod:PropertyModifier[] array = aObjectMod.GetPropertyModifiers()
		If (array)
			int index = 0
			While (index < array.Length)
				WriteLine(prefix, aObjectMod+" has PropertyModifier: "+array[index]+", @"+index)
				index += 1
			EndWhile
			return true
		Else
			WriteLine(prefix, aObjectMod+" has no property modifiers.")
			return false
		EndIf
	Else
		WriteLine(prefix, "Cannot trace property modifiers on none ObjectMod.")
		return false
	EndIf
EndFunction


; States
;---------------------------------------------

bool Function NewState(ScriptObject this, int stateID) Global
	If (this)
		this.StartTimer(0.1, stateID)
		return true
	Else
		WriteUnexpectedValue("Fallout:Scopes:Papyrus", "NewState", "this", "Cannot request state ID "+stateID+" on a none script.")
		return false
	EndIf
EndFunction


bool Function AwaitState(ScriptObject this, string statename = "Busy") Global
	{Polling until the given script is in the "empty" state.}
	If (this)
		If (BeginState(this, statename))
			While (StateRunning(this))
				Utility.Wait(0.1)
			EndWhile
			return true
		Else
			WriteUnexpected(this, "AwaitState", "Could not await the '"+statename+"' state.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("Fallout:Scopes:Papyrus", "AwaitState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function BeginState(ScriptObject this, string statename = "Busy") Global
	{Begins the given state without waiting for it to end.}
	If (this)
		If (StateRunning(this))
			WriteUnexpected(this, "BeginState", "Cannot start the '"+statename+"' state while '"+this.GetState()+"' state is running.")
			return false
		Else
			If (statename)
				If (ChangeState(this, statename))
					return true
				Else
					WriteUnexpected(this, "BeginState", "Start state cannot change state for the '"+statename+"' state.")
					return false
				EndIf
			Else
				WriteUnexpectedValue(this, "BeginState", "statename", "Cannot operate on a none or empty state.")
				return false
			EndIf
		EndIf
	Else
		WriteUnexpectedValue("Fallout:Scopes:Papyrus", "BeginState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function StateRunning(ScriptObject this) Global
	{Return true if the given script has any state other than the default empty state.}
	If (this)
		return this.GetState() != ""
	Else
		WriteUnexpectedValue("Fallout:Scopes:Papyrus", "StateRunning", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function ClearState(ScriptObject this) Global
	{Ends any running state on the given script.}
	If (this)
		If (ChangeState(this, ""))
			return true
		Else
			WriteUnexpected(this, "ClearState", "Unable to change the scripts state to empty.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("Fallout:Scopes:Papyrus", "ClearState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction


bool Function ChangeState(ScriptObject this, string statename) Global
	{Changes the given scripts state only to a different state.}
	If (this)
		If(this.GetState() != statename)
			this.GoToState(statename)
			return true
		Else
			WriteUnexpectedValue(this, "ChangeState", "statename", "The script is already in the '"+statename+"' state.")
			return false
		EndIf
	Else
		WriteUnexpectedValue("Fallout:Scopes:Papyrus", "ChangeState", "this", "The script cannot be none.")
		return false
	EndIf
EndFunction
