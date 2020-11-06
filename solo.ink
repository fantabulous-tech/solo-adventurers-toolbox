INCLUDE debug
INCLUDE code
INCLUDE settings

INCLUDE clue
INCLUDE dungeon
INCLUDE monsters
INCLUDE npc
INCLUDE quests
INCLUDE situations
INCLUDE story
INCLUDE tavern
INCLUDE travel
INCLUDE urban
INCLUDE wilderness


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
VAR debug = true
VAR current_weather = "Unknown Weather"

VAR dungeon_room_total = 0
VAR dungeon_room_found = 0
VAR dungeon_rooms = 0
VAR dungeon_clues = 0
VAR dungeon_passages = 0
VAR dungeon_stairs = 0
VAR dungeon_doors = 0
VAR dungeon_traps = 0
VAR dungeon_secret_doors = 0

VAR stat_survival_bonus = 0
VAR stat_level = 1
VAR stat_party_size = 2

LIST terrain = (unknown_terrain), aquatic, coastal, desert, dungeon, forest, grass, hill, mountain, swamp, urban
LIST season = (unknown_season), summer, autumn, winter, spring
LIST population = (pop_unknown), pop_low, pop_medium, pop_high
LIST time = (day), night
LIST cr_level = (cr0), cr1_8, cr1_4, cr1_2, cr1, cr2, cr3, cr4, cr5, cr6, cr7
LIST dungeon_size = (dng_unknown), dng_tiny, dng_small, dng_medium, dng_large, dng_huge, dng_limitless
LIST dungeon_type = (dtype_unknown), dtype_lair, dtype_tomb, dtype_stronghold, dtype_temple, dtype_cave, dtype_maze, dtype_mine, dtype_planar, dtype_hq, dtype_trap
LIST dungeon_destination = Passage, Room, Stairs


{ debug:
    ~log("Entering ink debug.")
    -> Debug ->
    ~log("Exiting ink debug.")
}


-> main_menu


=== main_menu ===
<b>Main Menu</b> #CLEAR

~ back_menu = main_menu

<- base_menu

+ [Travel] -> travel_menu -> main_menu
+ [Enter Dungeon] -> random_dungeon -> main_menu


=== base_menu ===

+ <b>[Settings]</b>
    -> edit_settings -> main_menu

+ <b>Roll Dice</b>
    -> roll_dice_menu -> main_menu

+ <b>Create</b>
    -> create_menu -> main_menu

+ Generic Skill Check
    -> skill_check ->
    ~again = -> skill_check

+ Yes/No Question
    -> yes_no_question ->
    ~again = -> yes_no_question



- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> main_menu




=== create_menu ===
+ Create Tavern
    -> create_tavern ->
    ~again = -> create_tavern

+ Create Clue
    -> create_clue ->
    ~again = -> create_clue

+ Create Quest
    -> create_quest ->
    ~again = -> create_quest

+ Create Creature
    -> create_creature ->
    ~again = -> create_creature

+ Create Monster
    -> monster_by_terrain_table ->
    ~again = -> monster_by_terrain_table

+ Create Structure
    -> create_structure ->
    ~again = -> create_structure

+ Create Unmarked Settlement
    -> unmarked_settlement_table ->
    ~again = -> unmarked_settlement_table

+ Create Wilderness Encounter
    -> wilderness_encounter_table ->
    ~again = -> wilderness_encounter_table

+ Create Story Event
    -> story_element_interaction_table ->
    ~again = -> story_element_interaction_table

+ Create Dungeon Room
    -> create_dungeon_room ->
    ~ again = -> create_dungeon_room

+ Create Dungeon Passage
    -> create_dungeon_passage ->
    ~ again = -> create_dungeon_passage

+ Create Dungeon Stairs
    -> create_dungeon_stairs ->
    ~ again = -> create_dungeon_stairs

+ Create Dungeon Door
    -> create_dungeon_door ->
    ~ again = -> create_dungeon_door

+ Create Secret Dungeon Door
    -> create_secret_door ->
    ~ again = -> create_secret_door

+ Create Trap
    -> create_trap ->
    ~ again = -> create_trap

+ [Back] -> back_menu

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> create_menu
