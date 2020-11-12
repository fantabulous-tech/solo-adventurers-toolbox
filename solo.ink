# title: Solo Adventurer's Toolbox
# theme: dark

INCLUDE debug
INCLUDE code
INCLUDE settings

INCLUDE clue
INCLUDE dungeon
INCLUDE loot
INCLUDE monsters
INCLUDE npc
INCLUDE quests
INCLUDE situations
INCLUDE story
INCLUDE tavern
INCLUDE travel
INCLUDE urban
INCLUDE wilderness


VAR debug = false

VAR difficulty = 15
VAR roll = 1
VAR bonus = 0
VAR result = 0
VAR chances = 0
VAR total = 0
VAR count = 0
VAR test = false
VAR again = -> main_menu
VAR current_weather = "Unknown Weather"

VAR dungeon_room_total = 0
VAR dungeon_room_found = 0
VAR dungeon_passages_found = 0
VAR dungeon_rooms = 0
VAR dungeon_clues = 0
VAR dungeon_passages = 0
VAR dungeon_stairs = 0
VAR dungeon_doors = 0
VAR dungeon_traps = 0
VAR dungeon_secret_doors = 0
VAR dungeon_content_bonus = 0
LIST dungeon_size = dng_tiny, dng_small, dng_medium, dng_large, dng_huge, dng_limitless
LIST dungeon_type = dtype_lair, dtype_tomb, dtype_stronghold, dtype_temple, dtype_cave, dtype_maze, dtype_mine, dtype_planar, dtype_hq, dtype_trap
LIST dungeon_destination = Passage, Room, Stairs

LIST urban_shops = tavern, supplies, mounts, books, gems, armourer, bank, tinkerer, tailor, potions, idols, food, temple, tomes, thieving, weapons, vehicles, guild, magic_items, blacksmith, resurrection, couriers, brothel, realty, carpenter, theatre, healer, boats, union, stonemason, university, mercenaries, animal_trainer
LIST urban_size = urb_camp, urb_hamlet, urb_village, urb_town, urb_city, urb_metropolis

LIST cr_list = cr0, cr1_8, cr1_4, cr1_2, cr1, cr2, cr3, cr4, cr5, cr6, cr7
LIST encounter_difficulty = easy, medium, hard, deadly

// encounter group 1
VAR monster_count = 0
VAR monster_level = ()

// encounter group 2
VAR monster_count_2 = 0
VAR monster_level_2 = ()

VAR stat_survival_bonus = 0
VAR stat_level = 1
VAR stat_party_size = 2

LIST location = wilderness, urban, dungeon
LIST terrain = aquatic, coastal, desert, forest, grass, hill, mountain, swamp
LIST season = summer, autumn, winter, spring
LIST population = pop_low, pop_medium, pop_high
LIST time = (day), night

{ debug:
    ~log("Entering ink debug.")
    -> Debug ->
    ~log("Exiting ink debug.")
}

~ season = LIST_RANDOM(LIST_ALL(season))
~ terrain = LIST_RANDOM(LIST_ALL(terrain))

-> roll_weather ->
-> main_menu


=== main_menu ===

<- menu
<- add_quick_menu(-> main_menu)
<- add_settings_menu(-> main_menu)
-> DONE

= menu
<b>Main Menu</b> ({DisplaySummary()})#CLEAR

+ [Enter Wilderness]
    ~ terrain = ()
    ~ population = ()
    ~ time = day
    -> wilderness_menu -> main_menu
+ [Enter {dungeon_size:New }Dungeon]
    ~ ResetDungeon()
    -> dungeon_menu -> main_menu
+ {dungeon_size}[Enter Previous Dungeon]
    -> dungeon_menu -> main_menu
+ [Enter Town/City]
    ~ urban_size = ()
    ~ time = day
    -> urban_menu -> main_menu




=== quick_menu ===
<- add_quick_menu(-> quick_menu)
<- add_settings_menu(-> quick_menu)
<- add_back_menu(-> back)
-> DONE

- (back)
->->


=== add_settings_menu(-> back) ===
+ [Settings] -> edit_settings -> back

=== add_back_menu(-> back) ===
+ [Back] -> back

=== add_quick_menu(-> back) ===

+ [Create Menu]
    -> create_menu ->

+ [Roll Dice Menu]
    -> roll_dice_menu ->

+ [Yes/No Question]
    -> yes_no_question ->

+ [Skill Check]
    -> skill_check ->

- -> back

=== create_menu ===
{location == ():-> edit_location ->}
{location == ():->->}

{location:
    - urban: -> create_urban_menu ->
    - wilderness: -> create_wilderness_menu ->
    - dungeon: -> create_dungeon_menu ->
    - else:
        ~ logError("Unknown Location {location}.")
}

- ->->

=== add_create_generic_menu(-> back) ===

+ Create NPC
    -> create_npc ->
    
+ Create Adventurer NPC
    -> create_adventurer ->

+ Create Loot
    -> create_loot ->
    -> roll_encounter ->

+ Create Hoard
    -> create_hoard ->
    -> roll_encounter ->

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> back



=== create_urban_menu ===
<- menu
<- add_create_generic_menu(-> create_urban_menu)
<- add_settings_menu(-> create_urban_menu)
<- add_back_menu(-> back)
-> DONE

- (back)
->->

= menu
<b>Create Town Stuff Menu</b> #CLEAR
 
+ Create Encounter
    -> create_encounter ->
    ~ again = -> create_encounter
    
+ Create Monster
    -> create_single_monster ->
    ~ again = -> create_single_monster

+ Create Tavern
    -> create_tavern ->
    ~ again = -> create_tavern

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> create_urban_menu


=== create_dungeon_menu ===
<- menu
<- add_create_generic_menu(-> create_dungeon_menu)
<- add_settings_menu(-> create_dungeon_menu)
<- add_back_menu(-> back)
-> DONE

- (back)
->->

= menu
<b>Dungeon Create Menu</b> #CLEAR

+ Create Encounter
    -> create_encounter ->
    ~ again = -> create_encounter
    
+ Create Monster
    -> create_single_monster ->
    ~ again = -> create_single_monster

+ Create Room
    -> create_dungeon_room ->
    ~ again = -> create_dungeon_room

+ Create Passage
    -> create_dungeon_passage ->
    ~ again = -> create_dungeon_passage

+ Create Stairs
    -> create_dungeon_stairs ->
    ~ again = -> create_dungeon_stairs

+ Create Door
    -> create_dungeon_door ->
    ~ again = -> create_dungeon_door

+ Create Secret Door
    -> create_secret_door ->
    ~ again = -> create_secret_door

+ Create Trap
    -> create_trap ->
    ~ again = -> create_trap

+ Create Clue
    -> create_dungeon_clue ->
    ~ again = -> create_dungeon_clue

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> create_dungeon_menu


=== create_wilderness_menu ===
<- menu
<- add_create_generic_menu(-> create_wilderness_menu)
<- add_settings_menu(-> create_wilderness_menu)
<- add_back_menu(-> back)
-> DONE

- (back)
->->

= menu
<b>Create Wilderness Stuff Menu</b> #CLEAR

+ Create Encounter
    -> create_encounter ->
    ~ again = -> create_encounter
    
+ Create Monster
    -> create_single_monster ->
    ~ again = -> create_single_monster

+ Create Clue
    -> create_wilderness_clue ->
    ~ again = -> create_dungeon_clue

+ Create Quest
    -> create_quest ->
    ~ again = -> create_quest

+ Create Creature
    -> create_creature ->
    ~ again = -> create_creature

+ Create Wilderness Encounter
    -> wilderness_encounter_table ->
    ~ again = -> wilderness_encounter_table

+ Create Story Event
    -> story_element_interaction_table ->
    ~ again = -> story_element_interaction_table
    
+ [Terrain Feature Menu]
    -> create_terrain_feature -> menu

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> create_wilderness_menu


=== create_terrain_feature ===
<- menu
<- add_create_generic_menu(-> create_terrain_feature)
<- add_settings_menu(-> create_terrain_feature)
<- add_back_menu(-> back)
-> DONE

- (back)
->->

= menu
<b>Create Terrain Feature Menu</b> #CLEAR
    
+ Create Clearfelled Area
    -> create_clearfelled_area ->
    ~ again = -> create_clearing
    
+ Create Clearing
    -> create_clearing ->
    ~ again = -> create_clearing
    
+ Create Gully
    -> create_gully ->
    ~ again = -> create_gully
    
+ Create Hills
    -> create_hills ->
    ~ again = -> create_hills
    
+ Create Landscape Feature
    -> create_landscape_feature ->
    ~ again = -> create_landscape_feature
    
+ Create Landscape Feature
    -> create_lake ->
    ~ again = -> create_lake
    
+ Create Monument
    -> create_monument ->
    ~ again = -> create_monument
    
+ Create Oasis
    -> create_oasis ->
    ~ again = -> create_oasis
    
+ Create Rocky Outcrop
    -> create_outcrop ->
    ~ again = -> create_outcrop
    
+ Create Small Mountain Range / Foothills
    -> create_mountains ->
    ~ again = -> create_mountains
    
+ Create Small Woods
    -> create_woods ->
    ~ again = -> create_mountains

+ Create Structure
    -> create_structure ->
    ~ again = -> create_structure

+ Create Swamp
    -> create_swamp ->
    ~ again = -> create_swamp

+ Create Unmarked Settlement
    -> create_unmarked_settlement ->
    ~ again = -> create_unmarked_settlement

+ Create Waterway
    -> create_waterway ->
    ~ again = -> create_waterway

+ Create Active Area Discovery
    -> create_discovery ->
    ~ again = -> create_discovery

+ [Back] ->->

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> create_terrain_feature





