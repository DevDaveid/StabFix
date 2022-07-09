#include <sourcemod>
#include <sdkhooks>

public Plugin myinfo =
{
    name = "StabFix",
    author = "Dave",
    description = "Fixes hns stab issue",
    version = "1.0.0",
    url = "https://github.com/DevDaveid"
};

public Action OnDamageCallback(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon,
		float damageForce[3], float damagePosition[3], int damagecustom)
{
    if(damagetype == 4100 && damage != 55.0)
        damage = 55.0;

    return Plugin_Changed;
}