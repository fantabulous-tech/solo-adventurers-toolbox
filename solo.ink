INCLUDE clue
INCLUDE dungeon
INCLUDE monsters
INCLUDE npc
INCLUDE quests
INCLUDE situations
INCLUDE stats
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
VAR again = -> main_menu

VAR stat_survival_bonus = 0

// ~ SEED_RANDOM(434544)

-> main_menu






=== main_menu ===
<b>Main Menu</b> #CLEAR


+ <b>[Edit Stats Menu]</b>
    -> edit_stats -> main_menu

+ <b>Roll Dice [Menu]</b>
    -> roll_dice_menu -> main_menu
    
+ <b>Dungeon Menu</b>
    -> dungeon_menu -> main_menu
    
+ <b>Wilderness/Travel Menu</b>
    -> wilderness_menu -> main_menu
    
+ <b>Create Menu</b>
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

+ Create Structure
    -> create_structure ->
    ~again = -> create_structure

+ Story Element Interaction Table
    -> story_element_interaction_table ->
    ~again = -> story_element_interaction_table

+ [Back] -> main_menu

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> create_menu


=== dungeon_menu ===

You can also use the <a href="https:\/\/watabou.itch.io/one-page-dungeon">One Page Dungeon Generator</a>
https:\/\/watabou.itch.io/one-page-dungeon

+ Dungeon Enounter Table
    -> dungeon_encounter_table ->
    ~ again = -> dungeon_encounter_table


- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> create_menu

=== wilderness_menu ===

+ Weather Check
    -> weather ->
    ~again = -> weather

+ Wilderness Encounter Check
    -> wilderness_encounter ->->

+ Wilderness Encounter Table
    -> wilderness_encounter_table ->
    ~again = -> wilderness_encounter_table

+ Unmarked Settlement Check
    -> unmarked_settlement_check ->
    ~again = -> unmarked_settlement_check

+ Unmarked Settlement Table
    -> unmarked_settlement_table ->
    ~again = -> unmarked_settlement_table
    
+ Find Campsite Check
    -> find_campsite_check ->
    ~again = -> find_campsite_check

+ Disturbances While Camping Check
    -> disturbance_while_camping_check ->
    ~again = -> disturbance_while_camping_check


+ Wilderness Encounter Table
    -> wilderness_encounter_table ->
    ~again = -> wilderness_encounter_table

+ Monster by Terrain Table
    -> monster_by_terrain_table ->
    ~again = -> monster_by_terrain_table

+ [Back] -> main_menu

- (sub_menu)
+ [Again] -> again -> sub_menu
+ [Back] -> wilderness_menu



=== roll_dice_menu ===
+ 1d4[] Result: {d4()}
+ 1d6[] Result: {d6()}
+ 1d8[] Result: {d8()}
+ 1d10[] Result: {d10()}
+ 1d12[] Result: {d12()}
+ 1d20[] Result: {d20()}
+ 1d100[] Result: {d100()}
+ [Back] -> main_menu

- -> roll_dice_menu




=== yes_no_test(question, -> yes, -> no, -> maybe) ===
{question}

+ Impossible (-6)
    ~ bonus = -6
+ Highly Unlikely (-4)
    ~ bonus = -4
+ Unlikely (-2)
    ~ bonus = -2
+ Possible (0)
    ~ bonus = 0
+ Likely (+2)
    ~ bonus = 2
+ Highly Likely (+4)
    ~ bonus = 4
+ A Certainty (+6)
    ~ bonus = 6
    
-
~ roll = d20()
~ result = roll + bonus

{
- result <= 6:
    No. {result} ({roll}🎲+{bonus}) < 6
    -> no
- result <= 12:
    Maybe. 6 < {result} ({roll}🎲+{bonus}) <= 12)
    -> maybe
- else:
    Yes. {result} ({roll}🎲+{bonus}) > 12
    -> yes
}


=== yes_no_question ===
Given all circumstances, how likely is the occurrence?

+ Impossible (-6)
    ~ bonus = -6
+ Highly Unlikely (-4)
    ~ bonus = -4
+ Unlikely (-2)
    ~ bonus = -2
+ Possible (0)
    ~ bonus = 0
+ Likely (+2)
    ~ bonus = 2
+ Highly Likely (+4)
    ~ bonus = 4
+ A Certainty (+6)
    ~ bonus = 6
    
-
~ roll = d20()
~ result = roll + bonus

{
- result <= 6:
    No. {result} ({roll}🎲+{bonus}) < 6
- result <= 12:
    Maybe. 6 < {result} ({roll}🎲+{bonus}) <= 12)
    
    There is some other condition that needs to be fulfilled for the thing to happen (or not happen, as the case may be), perhaps an appropriate ability check to overcome a relevant obstacle or achieve a stated goal. Or, it could be that other yes/no/maybe questions need to be asked in order to determine what the condition is. Another way of getting answers to a maybe is to make a roll or two on the Situations table in Chapter 15. That might add the necessary detail. Or, if you get a maybe roll, you can just decide whether it’s yes or no yourself.
- else:
    Yes. {result} ({roll}🎲+{bonus}) > 12
}
->->

=== skill_check ===
Skill:
+ -5
    ~ bonus = -5
+ -4
    ~ bonus = -4
+ -3
    ~ bonus = -3
+ -2
    ~ bonus = -2
+ -1
    ~ bonus = -1
+ 0
    ~ bonus = 0
+ \+1
    ~ bonus = 1
+ \+2
    ~ bonus = 2
+ \+3
    ~ bonus = 3
+ \+4
    ~ bonus = 4
+ \+5
    ~ bonus = 5

- 
Difficulty:

+ Very Easy (5)
    ~ difficulty = 5
+ Easy (10)
    ~ difficulty = 10
+ Moderate (15)
    ~ difficulty = 15
+ Hard (20)
    ~ difficulty = 20
+ Very Hard (25)
    ~ difficulty = 25
+ Nearly Impossible (30)
    ~ difficulty = 30

-

~ roll = d20()
~ result = roll + bonus

{
- roll == 20:
    Critical success!
- roll == 1:
    Critical failure!
- result >= difficulty:
    Success!
- else:
    Failure!
}

-> display_result ->->


=== display_result ===
{bonus == 0:
    <> ({roll}🎲)
- else:
    <> ({roll}🎲{DisplayBonus(bonus)} = {result})
}

->->


=== display_result_target(target) ===
{bonus == 0:
    <> ({roll}🎲/{target})
- else:
    <> ({roll}🎲{DisplayBonus(bonus)} = {result}/{target})
}

->->

=== function DisplayBonus(b) ===
{b >= 0:
    ~ return "+{b}"
- else:
    ~ return b
}

=== function P(target) ===
~ return d100() <= target

=== function d4 ===
~ return RANDOM(1,4)

=== function d6 ===
~ return RANDOM(1,6)

=== function d8 ===
~ return RANDOM(1,8)

=== function d10 ===
~ return RANDOM(1,10)

=== function d12 ===
~ return RANDOM(1,12)

=== function d20 ===
~ return RANDOM(1,20)

=== function d100 ===
~ return RANDOM(1,100)





