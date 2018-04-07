Scriptname Fallout:Scopes:Menu extends Quest
import Fallout
import Fallout:Scopes:Papyrus

CustomEvent OpenCloseEvent
CustomEvent BreathEvent

Actor Player
string ModelPath
bool BreathPressed = false
bool Interrupted = false

int BipedWeapon = 41 const


; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	RegisterForRemoteEvent(Player, "OnPlayerModArmorWeapon")
	RegisterForMenuOpenCloseEvent(Name)
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
EndEvent


Event Actor.OnItemEquipped(Actor sender, Form akBaseObject, ObjectReference akReference)
	If (akBaseObject is Weapon)
		ModelPath = GetModelPath()
	EndIf
EndEvent


Event Actor.OnPlayerModArmorWeapon(Actor sender, Form akBaseObject, ObjectMod akModBaseObject)
	If (akBaseObject is Weapon)
		ModelPath = GetModelPath()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	BreathPressed = false

	If (opening)
		string overlay = ConvertFileExtension(ModelPath, "swf")
		WriteLine(self, "OnMenuOpenCloseEvent: The converted overlay path is "+overlay)
		SetCustom(overlay)
		RegisterForKey(BreathKey)
	Else
		UnregisterForKey(BreathKey)
	EndIf

	OpenCloseEventArgs e = new OpenCloseEventArgs
	e.Opening = opening
	self.SendOpenCloseEvent(e)
EndEvent


Event OnKeyDown(int keyCode)
	BreathPressed = true
	BreathEventArgs e = new BreathEventArgs
	e.Breath = BreathHeld
	self.SendBreathEvent(e)
EndEvent


Event OnKeyUp(int keyCode, float time)
	BreathPressed = false
	If (Interrupted)
		Interrupted = false
	Else
		BreathEventArgs e = new BreathEventArgs
		e.Breath = BreathReleased
		self.SendBreathEvent(e)
	EndIf
EndEvent


; Methods
;---------------------------------------------

string Function GetModelPath()
	ObjectMod[] array = Player.GetWornItemMods(BipedWeapon)
	If (array)
		int index = 0
		While (index < array.Length)
			ObjectMod omod = array[index]
			If (omod.HasWorldModel() && IsScope(omod))
				return omod.GetWorldModelPath()
			EndIf
			index += 1
		EndWhile
		return none
	EndIf
EndFunction


bool Function IsScope(ObjectMod omod)
	If (omod)
		ObjectMod:PropertyModifier[] properties = omod.GetPropertyModifiers()
		bool bHasScope = properties.FindStruct("object", HasScope) > Invalid
		return bHasScope || properties.FindStruct("object", HasScopeRecon) > Invalid
	Else
		return false
	EndIf
EndFunction


string Function ConvertFileExtension(string filePath, string toExtension)
	If (filePath)
		If (toExtension)
			var[] arguments = new var[2]
			arguments[0] = filePath
			arguments[1] = toExtension
			return UI.Invoke(Name, GetMember("ConvertFileExtension"), arguments)
		Else
			WriteLine(self, "ConvertFileExtension: Argument toExtension cannot be none or empty.")
			return none
		EndIf
	Else
		WriteLine(self, "ConvertFileExtension: Argument filePath cannot be none or empty.")
		return none
	EndIf
EndFunction


Function SetCustom(string filePath)
	If (filePath)
		var[] arguments = new var[1]
		arguments[0] = filePath
		UI.Invoke(Name, GetMember("SetCustom"), arguments)
		WriteLine(self, "SetCustom:"+filePath)
	Else
		WriteLine(self, "SetCustom: Argument filePath cannot be none or empty.")
	EndIf
EndFunction


Function SetOverlay(int identifier)
	If (identifier >= Default && identifier <= Empty)
		var[] arguments = new var[1]
		arguments[0] = identifier
		UI.Invoke(Name, GetMember("SetOverlay"), arguments)
		WriteLine(self, "SetOverlay:"+identifier)
	Else
		WriteLine(self, "SetOverlay: Argument "+identifier+" is out of range.")
	EndIf
EndFunction


; Functions
;---------------------------------------------

string Function GetMember(string member)
	If (member)
		return Instance+"."+member
	Else
		WriteLine(self, "GetMember: Argument member cannot be none or empty.")
		return none
	EndIf
EndFunction


string Function GetMemberCustom(string member)
	If (member)
		string custom = UI.Invoke(Name, GetMember("GetCustom"))
		If (custom)
			return custom+"."+member
		Else
			WriteLine(self, "GetMemberCustom : custom : Could not get an instance for the "+member+" member.")
			return none
		EndIf
	Else
		WriteLine(self, "GetMemberCustom : member : Argument cannot be none or empty.")
		return none
	EndIf
EndFunction


; Open Event
;---------------------------------------------

Function SendOpenCloseEvent(OpenCloseEventArgs e)
	If (e)
		var[] arguments = new var[1]
		arguments[0] = e
		self.SendCustomEvent("OpenCloseEvent", arguments)
	Else
		WriteLine(self, "SendOpenCloseEvent : e : Cannot be none.")
	EndIf
EndFunction


bool Function RegisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteLine(self, "RegisterForOpenCloseEvent : script : Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForOpenCloseEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "OpenCloseEvent")
		return true
	Else
		WriteLine(self, "UnregisterForOpenCloseEvent : script : Cannot unregister a none script for events.")
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

Function SendBreathEvent(BreathEventArgs e)
	If (e)
		If (e.Breath == BreathInterrupted)
			Interrupted = true
		EndIf
		var[] arguments = new var[1]
		arguments[0] = e
		self.SendCustomEvent("BreathEvent", arguments)
	Else
		WriteLine(self, "SendBreathEvent : e : Cannot be none.")
	EndIf
EndFunction


bool Function RegisterForBreathEvent(ScriptObject script)
	If (script)
		script.RegisterForCustomEvent(self, "BreathEvent")
		return true
	Else
		WriteLine(self, "RegisterForBreathEvent : script : Cannot register a none script for events.")
		return false
	EndIf
EndFunction


bool Function UnregisterForBreathEvent(ScriptObject script)
	If (script)
		script.UnregisterForCustomEvent(self, "BreathEvent")
		return true
	Else
		WriteLine(self, "UnregisterForBreathEvent : script : Cannot unregister a none script for events.")
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


; Globals
;---------------------------------------------

Scopes:Menu Function ScopeMenu() Global
	return Game.GetFormFromFile(0x01000F99, "Scopes.esp") as Scopes:Menu
EndFunction


; Properties
;---------------------------------------------

Group Properties
	Keyword Property HasScope Auto Const Mandatory
	{The keyword an OMOD must add via its property modifiers.}

	Keyword Property HasScopeRecon  Auto Const Mandatory
	{The keyword an OMOD must add via its property modifiers.}

	string Property Name Hidden
		string Function Get()
			return "ScopeMenu"
		EndFunction
	EndProperty

	string Property Instance Hidden
		string Function Get()
			return "root1.ScopeMenuInstance"
		EndFunction
	EndProperty

	bool Property IsOpen Hidden
		bool Function Get()
			return UI.IsMenuOpen(Name)
		EndFunction
	EndProperty

	Weapon Property Equipped Hidden
		Weapon Function Get()
			return Player.GetEquippedWeapon()
		EndFunction
	EndProperty

	int Property Invalid = -1 AutoReadOnly
EndGroup

Group Identifiers
	int Property Default = 0 AutoReadOnly
	int Property Fine = 1 AutoReadOnly
	int Property Duplex = 2 AutoReadOnly
	int Property German = 3 AutoReadOnly
	int Property Dot = 4 AutoReadOnly
	int Property MilDot = 5 AutoReadOnly
	int Property Circle = 6 AutoReadOnly
	int Property OldRangefind = 7 AutoReadOnly
	int Property ModernRangefind = 8 AutoReadOnly
	int Property SVD = 9 AutoReadOnly
	int Property HandPainted = 10 AutoReadOnly
	int Property Binoculars = 11 AutoReadOnly
	int Property M14NightVision = 12 AutoReadOnly
	int Property Zero = 13 AutoReadOnly
	int Property InternalRangefinder = 14 AutoReadOnly
	int Property Rangefinder00 = 15 AutoReadOnly
	int Property AssaultRifle_REC = 16 AutoReadOnly
	int Property GaussRiflePrototypeA = 17 AutoReadOnly
	int Property GaussRiflePrototypeB = 18 AutoReadOnly
	int Property Empty = 19 AutoReadOnly
EndGroup

Group Breath
	ActorValue Property ActionPoints Auto Const Mandatory

	int Property BreathKey = 164 AutoReadOnly

	int Property BreathHeld = 0 AutoReadOnly
	int Property BreathReleased = 1 AutoReadOnly
	int Property BreathInterrupted = 2 AutoReadOnly

	bool Property IsBreathKeyDown Hidden
		bool Function Get()
			return BreathPressed
		EndFunction
	EndProperty

	bool Property HasBreath Hidden
		bool Function Get()
			return Player.GetValue(ActionPoints) > 0
		EndFunction
	EndProperty
EndGroup

Struct OpenCloseEventArgs
	bool Opening = false
EndStruct

Struct BreathEventArgs
	int Breath = -1
EndStruct
