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
VAR back_menu = -> main_menu
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


=== settings_menu ===

+ [Settings]
    -> edit_settings ->->


=== main_menu ===
<- menu
<- settings_menu
-> DONE

= menu
<b>Main Menu</b> ({DisplaySummary()})#CLEAR
~ back_menu = -> main_menu

+ [Enter Wilderness]
    ~ terrain = ()
    -> wilderness_menu -> main_menu
+ [Enter {dungeon_size:New }Dungeon]
    ~ ResetDungeon()
    -> dungeon_menu -> main_menu
+ {dungeon_size}[Enter Previous Dungeon]
    -> dungeon_menu -> main_menu
+ [Enter Town/City]
    ~ urban_size = ()
    -> urban_menu -> main_menu

+ [Roll Dice]
    -> roll_dice_menu -> main_menu

+ [Create]
    -> create_menu -> main_menu

+ [Skill Check]
    -> skill_check ->
    ~again = -> skill_check

+ [Yes/No Question]
    -> yes_no_question ->
    ~again = -> yes_no_question

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> main_menu




=== create_menu ===
<- menu
<- settings_menu
-> DONE

= menu
<b>Create Menu</b> #CLEAR
~ back_menu = -> create_menu

+ Create Town Stuff
    ~ location = urban
    -> create_town_menu -> create_menu

+ Create Wilderness Stuff
    ~ location = wilderness
    -> create_wilderness_menu -> create_menu

+ Create Dungeon Stuff
    ~ location = dungeon
    -> create_dungeon_menu -> create_menu

+ Create NPC
    -> create_npc ->
    ~ again = -> create_npc
    
+ Create Adventurer NPC
    -> create_adventurer ->
    ~ again = -> create_adventurer

+ Create Loot
    -> create_loot ->
    -> roll_encounter ->
    ~ again = -> create_loot

+ Create Hoard
    -> create_hoard ->
    -> roll_encounter ->
    ~ again = -> create_hoard

+ [Back] ->->

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> create_menu


=== create_town_menu ===
<- menu
<- settings_menu
-> DONE

= menu

+ Create Encounter
    -> create_encounter ->
    ~ again = -> create_encounter
    
+ Create Monster
    -> create_single_monster ->
    ~ again = -> create_single_monster

+ Create Tavern
    -> create_tavern ->
    ~ again = -> create_tavern

+ [Back] -> back_menu

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> back_menu


=== create_wilderness_menu ===
<- menu
<- settings_menu
-> DONE

= menu

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

+ Create Structure
    -> create_structure ->
    ~ again = -> create_structure

+ Create Unmarked Settlement
    -> create_unmarked_settlement ->
    ~ again = -> create_unmarked_settlement

+ Create Wilderness Encounter
    -> wilderness_encounter_table ->
    ~ again = -> wilderness_encounter_table

+ Create Story Event
    -> story_element_interaction_table ->
    ~ again = -> story_element_interaction_table
    
+ Create Oasis
    -> create_oasis ->
    ~ again = -> create_oasis

+ [Back] -> back_menu

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> back_menu




=== create_dungeon_menu ===
<- menu
<- settings_menu
-> DONE

= menu
<b>Dungeon Create Menu</b>

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

+ [Back] -> back_menu

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> back_menu




