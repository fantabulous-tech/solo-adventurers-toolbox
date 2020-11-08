
=== story_element_interaction_table ===
~ count = 0
~ total = 4

Story Event:

- (roll_again)
~ count++
~ roll = d20()

{
    - roll <= 6: -> event ->
    - roll <= 8: -> creature ->
    - roll <= 12: -> npcs ->
    - roll <= 20: -> situations ->
}

{count < total: -> roll_again}

->->


= npcs
NPC: <>
-> create_npc ->

->->

= situations
Situation: <>
-> create_situation ->
->->

= event
Event: <>
{location:
    - urban: -> urban_event ->
    - dungeon: -> dungeon_event ->
    - wilderness: -> wilderness_event ->
}

->->

= creature
Creature: <>
-> create_creature ->->

