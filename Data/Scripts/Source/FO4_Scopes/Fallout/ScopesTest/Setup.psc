Scriptname Fallout:ScopesTest:Setup extends Quest Const DebugOnly
{Temporary script to add in game items to test this project.}
import Fallout:Scopes:Papyrus

Actor Player
int count = 1 const
bool silent = true const

; Events
;---------------------------------------------

Event OnQuestInit()
	Player = Game.GetPlayer()

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

	Try(MisriahArmory, M319_IGL)
	Try(MisriahArmory, Magnum)
	Try(MisriahArmory, M45Tactical)
	Try(MisriahArmory, SRS99)
	Try(MisriahArmory, HM500)
	Try(MisriahArmory, MA5D)
	Try(MisriahArmory, M7_SMG)
	Try(MisriahArmory, DMR)
	Try(MisriahArmory, DMR_Gauss)

	WriteNotification(self, "Fallout Scopes has added test items.")
EndEvent


; Functions
;---------------------------------------------

Function Try(string plugin, int formID)
	If (Game.IsPluginInstalled(plugin))
		Form item = Game.GetFormFromFile(formID, plugin)
		If (item)
			Player.AddItem(item, 1, Silent)
		EndIf
	EndIf
EndFunction


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

Group Misriah
	string Property MisriahArmory = "MisriahArmory.esp" AutoReadOnly
	int Property M319_IGL = 0x00004545 AutoReadOnly ; M319_IGL "M319 Grenade Launcher" [WEAP:00004545]
	int Property Magnum = 0x00004B83 AutoReadOnly ; Magnum "Magnum" [WEAP:00004B83]
	int Property M45Tactical = 0x000090F4 AutoReadOnly ; M45Tactical "M45 Tactical Shotgun" [WEAP:000090F4]
	int Property SRS99 = 0x0000BEB2 AutoReadOnly ; MisriahSRS99 "SRS99" [WEAP:0000BEB2]
	int Property HM500 = 0x00011882 AutoReadOnly ; HM500 "HM500" [WEAP:00011882]
	int Property MA5D = 0x0002D4E5 AutoReadOnly ; MA5D "MA5D ICWS" [WEAP:0002D4E5]
	int Property M7_SMG = 0x000426B0 AutoReadOnly ; M7_SMG "Submachine Gun" [WEAP:000426B0]
	int Property DMR = 0x0005BDA4 AutoReadOnly ; DMR "M392 DMR" [WEAP:0005BDA4]
	int Property DMR_Gauss = 0x000644FF AutoReadOnly ; DMR_Gauss "XM392-B DMGR" [WEAP:000644FF]
EndGroup
