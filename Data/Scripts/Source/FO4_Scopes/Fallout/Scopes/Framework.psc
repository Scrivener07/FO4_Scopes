ScriptName Fallout:Scopes:Framework extends Fallout:Scopes:Type
import Fallout
import Fallout:Scopes
import Fallout:Scopes:Client
import Fallout:Scopes:Papyrus

Actor Player

string File
int BipedWeapon = 41 const

bool BreathPressed = false
bool Interrupted = false


; Events
;---------------------------------------------

; TODO: Use the game reload event
Event OnQuestInit()
	Player = Game.GetPlayer()
	RegisterForRemoteEvent(Player, "OnItemEquipped")
	RegisterForRemoteEvent(Player, "OnPlayerModArmorWeapon")
	RegisterForMenuOpenCloseEvent(Menu.Name)
EndEvent


Event OnQuestShutdown()
	UnregisterForAllEvents()
EndEvent


Event Actor.OnItemEquipped(Actor sender, Form akBaseObject, ObjectReference akReference)
	If (akBaseObject is Weapon)
		File = GetModelPath()
	EndIf
EndEvent


Event Actor.OnPlayerModArmorWeapon(Actor sender, Form akBaseObject, ObjectMod akModBaseObject)
	If (akBaseObject is Weapon)
		File = GetModelPath()
	EndIf
EndEvent


Event OnMenuOpenCloseEvent(string menuName, bool opening)
	BreathPressed = false
	If (opening)
		Menu.Load(File)
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


; Client
;---------------------------------------------

Function SendOpenCloseEvent(OpenCloseEventArgs e)
	If (e)
		var[] arguments = new var[1]
		arguments[0] = e
		Client.SendCustomEvent("OpenCloseEvent", arguments)
	Else
		WriteUnexpectedValue(self, "SendOpenCloseEvent", "e", "The argument cannot be none.")
	EndIf
EndFunction


Function SendBreathEvent(BreathEventArgs e)
	If (e)
		If (e.Breath == BreathInterrupted)
			Interrupted = true
		EndIf
		var[] arguments = new var[1]
		arguments[0] = e
		Client.SendCustomEvent("BreathEvent", arguments)
	Else
		WriteUnexpectedValue(self, "SendBreathEvent", "e", "The argument cannot be none.")
	EndIf
EndFunction


; Properties
;---------------------------------------------

Group Scopes
	Scopes:Menu Property Menu Auto Const Mandatory
	Scopes:Client Property Client Auto Const Mandatory
EndGroup

Group Properties
	Keyword Property HasScope Auto Const Mandatory
	{The keyword an OMOD must add via its property modifiers.}

	Keyword Property HasScopeRecon  Auto Const Mandatory
	{The keyword an OMOD must add via its property modifiers.}

	Weapon Property Equipped Hidden
		Weapon Function Get()
			return Player.GetEquippedWeapon()
		EndFunction
	EndProperty
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
