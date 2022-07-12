#include <sourcemod>
#include <sdkhooks>

bool g_StabCoolDown[MAXPLAYERS+1] = { true, ... };

public Plugin myinfo =
{
    name = "StabFix",
    author = "Dave",
    description = "Fixes hns stab issue",
    version = "1.1.0",
    url = "https://github.com/DevDaveid"
};

public void OnPluginStart()
{
    for(int i = 1; i <= MaxClients; i++)
    {
        if(IsClientInGame(i))
            if(!IsFakeClient(i))
                OnClientPutInServer(i);
    }
}

public void OnClientPutInServer(int client) 
{
    SDKHook(client, SDKHook_OnTakeDamage, OnDamageCallback);
}

public Action OnDamageCallback(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3])
{
    if(damagetype == 4100 && g_StabCoolDown[victim])
    {
        g_StabCoolDown[victim] = false;
        CreateTimer(3.0, StabCoolDown, victim);
        SetEntityRenderColor(victim, 0, 255, 0, 255);
        if(damage != 55.0)
        {
            damage = 55.0;
            return Plugin_Changed;
        }
    } else if(damagetype == 4100 && !g_StabCoolDown[victim])
    {
        return Plugin_Handled;
    }

    return Plugin_Continue;
}

Action StabCoolDown(Handle timer, int client)
{
    g_StabCoolDown[client] = true;
    SetEntityRenderColor(client, 255, 255, 255, 255);
    KillTimer(timer);
}
