#include <sourcemod>
#include <sdktools>

public Plugin myinfo =
{
	name = "noRPG/noSpawnSmg",
	author = "Neidermeyer",
	description = "This plug-in enables you to remove RPG from maps or replace it with SMGs. You can also remove SMG from spawning inventory",
	version = "0.0",
	url = "http://sfc.my1.ru/forum/38-384-1"
};

new Handle:RPG;
new Handle:SMG;

new SMGOffset = 28;

public void OnPluginStart()
{
	RPG = CreateConVar("allow_RPG", "0", "1 to allow RPG");
	SMG = CreateConVar("allow_SMG", "1", "1 to allow players to spawn with SMG");
	
	HookEvent("player_spawn", Event_PlayerSpawn);
}

public OnMapStart()
{
	if (GetConVarInt(RPG) == 0){
		new ent = -1
		if (GetConVarInt(SMG) == 0){ //Replace RPGs with SMGs
			
			}else if (GetConVarInt(SMG) == 1){ //Only remove RPG
			//while ((ent = FindEntityByClassname(ent,"weapon_rpg")) >= 0 /*|| ent = FindEntityByClassname(ent,"item_rpg_round")*/)
			new String:entName[32];
			for(new i = 0; i <= GetMaxEntities(); i++){
				if(!IsValidEntity(i)) continue;
				
				if(GetEdictClassname(i, entName, sizeof(entName))){
					if(StrEqual("weapon_rpg", entName, false) || StrEqual("item_rpg_round", entName, false))
					RemoveEdict(i);
				}
			}
		}
	}
}

public void Event_PlayerSpawn(Event event, const char[] name, bool dontBroadcast)
{
    if (GetConVarInt(SMG) == 0){ 
		new slot = 3;
		new client = GetClientOfUserId(GetEventInt(event, "userid"));
		new offs = FindDataMapOffs(client, "m_hMyWeapons");
		new ent = GetEntDataEnt2(client, offs + SMGOffset);
		PrintToChat(client, "weapon in 3rd slot has index %d", ent);
		RemovePlayerItem(client, ent);
		RemoveEdict(ent);
	}
}