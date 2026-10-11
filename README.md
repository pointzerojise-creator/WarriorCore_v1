# WarriorCore

One plugin, many switchable modules. Paper 1.20.x - 1.21.x, Java 17+.

| Module | What it does | Config file |
|---|---|---|
| worlds | Create/import/delete worlds, void worlds, per-world gamemode / pvp / difficulty / keepInventory, `/play <world>` | modules/worlds.yml |
| economy | Money, `/pay`, `/baltop`, admin `/eco`, PlaceholderAPI | modules/economy.yml |
| shop | GUI shop from config (`/shop`, `/sell hand`) - needs economy | modules/shop.yml |
| lifesteal | Hearts, heart item + recipe from config, revive, elimination, `enabled-worlds` | modules/lifesteal.yml |
| lobby | `/lobby` `/hub` `/setlobby`, join items, lobby protection, void rescue | modules/lobby.yml |
| menu | GUI menus you design in config (gamemode selector included) | modules/menu.yml |

Turn modules on/off in `config.yml` (restart after). After editing a module file run `/wcore reload`.

## Build (JDK 17+ and Maven)

    mvn -q package        # -> target/WarriorCore-1.0.0.jar

Termux: `pkg install openjdk-17 maven`, then run the command inside this folder.
Put the jar in `plugins/` and RESTART the server (do not use /reload).
Optional: PlaceholderAPI. Remove other lifesteal / economy / shop plugins that do the same job.

## First-time setup (the gamemode lobby)

1. Create the gamemode worlds (console or in-game):

       mw create lobby void
       mw create lifesteal
       mw create survival
       mw create creative flat
       mw create pvp flat

2. Per-world rules:

       mw set lobby gamemode adventure
       mw set lobby pvp false
       mw set creative gamemode creative
       mw set survival pvp false
       mw set lifesteal pvp true
       mw set pvp pvp true

3. Go to the lobby (`mw tp lobby`), paste your lobby build, stand on the spawn spot and run `/setlobby`.
   Stand where players should arrive in each world and run `/mw setspawn`.
4. Players type `/gamemodes` (or right-click the compass) to open the selector.
   Edit modules/menu.yml to change names, icons and worlds.
5. In modules/lifesteal.yml, `enabled-worlds` is already set to `lifesteal`, so hearts only count there.

## NPC click actions (FancyNpcs)

    /npc action <npc> any_click add player_command menu open gamemodes
    /npc action <npc> any_click add player_command play lifesteal

`/play <world>` only works for worlds listed under `public-worlds` in modules/worlds.yml.
(Menus run `[world]` actions directly, so no permission is needed for those.)

## Commands

    /wcore reload | modules                                   warriorcore.admin
    /mw create <name> [type] [env] [seed]                      warriorcore.worlds.admin
        types: normal flat void amplified large_biomes   envs: normal nether the_end
    /mw import <name> | tp <world> [player] | list | setspawn | delete <world> confirm
    /mw set <world> <gamemode|pvp|difficulty|keepinventory> <value>
    /play <world>                                              everyone (public-worlds only)
    /balance [player]  /pay <player> <amount>  /baltop         everyone
    /eco give|take|set|reset <player> [amount]                 warriorcore.economy.admin
    /shop   /sell hand                                         everyone
    /hearts [player]  /withdrawheart [n]  /revive <player>     everyone
    /wls reload|set|add|remove|give|revive|info                warriorlifesteal.admin
    /lobby (/hub)   /setlobby                                  everyone / warriorcore.lobby.admin
    /menu open <id> [player] | list                            everyone / warriorcore.menu.admin

Admins (op) bypass forced gamemodes (`warriorcore.worlds.bypass`) and lobby protection (`warriorcore.lobby.bypass`).

## Placeholders (PlaceholderAPI)

    %warriorlifesteal_hearts%  _hearts_max  _health  _hearts_bar  _eliminated  _enabled  _top_1_name  _top_1_hearts
    %warrioreconomy_balance%  _balance_formatted  _top_1_name  _top_1_balance

## Data files (plugins/WarriorCore/)

worlds-data.yml, economy-data.yml, lifesteal-data.yml, lobby-data.yml - managed by the plugin, don't edit while running.

## Not included yet

Crates, OneBlock, Skyblock, a Vault bridge (so other plugins can use the money). Use WorldEdit for building and FancyNpcs for NPCs.
