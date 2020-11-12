# title: Solo Adventurer's Toolbox
# theme: dark

INCLUDE debug
INCLUDE menus
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




