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

