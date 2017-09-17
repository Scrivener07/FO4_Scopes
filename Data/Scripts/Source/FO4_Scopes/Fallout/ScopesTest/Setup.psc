Scriptname Fallout:ScopesTest:Setup extends Quest Const DebugOnly
{Temporary script to add in game items to test this project.}
import Fallout:Scopes:Papyrus

; Events
;---------------------------------------------

Event OnQuestInit()
	Actor Player = Game.GetPlayer()
	int count = 1 const
	bool silent = true const
	Player.AddItem(LL_44_Pistol_Scoped, count, silent)
	Player.AddItem(LL_HuntingRifle_Sniper, count, silent)
	Player.AddItem(Aspiration_Weapon_Railroad_SniperRifle, count, silent)
	Player.AddItem(LL_AssaultRifle_Rifle_Sniper, count, silent)
	Player.AddItem(LL_CombatRifle_Sniper, count, silent)
	Player.AddItem(LL_GaussRifle_Sniper, count, silent)
	Player.AddItem(LL_InstituteLaserGun_Rifle_SuperSniper, count, silent)
	Player.AddItem(LL_LaserGun_SniperRifle, count, silent)
	Player.AddItem(LL_PipeBoltAction_SniperRifle, count, silent)
	Player.AddItem(LL_PipeGun_SniperRifle, count, silent)
	Player.AddItem(LL_PlasmaGun_SniperRifle_SemiAuto, count, silent)
	Player.AddItem(LL_Weapons_Guns_Long, count, silent)
	Player.AddItem(LL_Weapons_Guns_Short, count, silent)
	Player.AddItem(LLI_Gunner_Sniper, count, silent)
	WriteNotification(self, "Fallout Scopes has added test items.")
EndEvent


; Properties
;---------------------------------------------

Group Properties
	LeveledItem Property LL_44_Pistol_Scoped Auto Const Mandatory
	LeveledItem Property LL_HuntingRifle_Sniper Auto Const Mandatory
	LeveledItem Property Aspiration_Weapon_Railroad_SniperRifle Auto Const Mandatory
	LeveledItem Property LL_AssaultRifle_Rifle_Sniper Auto Const Mandatory
	LeveledItem Property LL_CombatRifle_Sniper Auto Const Mandatory
	LeveledItem Property LL_GaussRifle_Sniper Auto Const Mandatory
	LeveledItem Property LL_InstituteLaserGun_Rifle_SuperSniper Auto Const Mandatory
	LeveledItem Property LL_LaserGun_SniperRifle Auto Const Mandatory
	LeveledItem Property LL_PipeBoltAction_SniperRifle Auto Const Mandatory
	LeveledItem Property LL_PipeGun_SniperRifle Auto Const Mandatory
	LeveledItem Property LL_PlasmaGun_SniperRifle_SemiAuto Auto Const Mandatory
	LeveledItem Property LL_Weapons_Guns_Long Auto Const Mandatory
	LeveledItem Property LL_Weapons_Guns_Short Auto Const Mandatory
	LeveledItem Property LLI_Gunner_Sniper Auto Const Mandatory
EndGroup
