Scriptname Fallout:Scopes:Setup extends Quest


Event OnQuestInit()
	Actor Player = Game.GetPlayer()
	Player.AddItem(LL_44_Pistol_Scoped)
	Player.AddItem(LL_HuntingRifle_Sniper)
EndEvent


; Properties
;---------------------------------------------

Group Properties
	LeveledItem Property LL_44_Pistol_Scoped Auto Const Mandatory
	LeveledItem Property LL_HuntingRifle_Sniper Auto Const Mandatory
EndGroup
