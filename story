
=== story_element_interaction_table ===
~ count = 0
~ total = 4

{terrain == unknown_terrain: -> edit_terrain ->}

Story Seed:

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
{terrain:
    - urban: -> urban_event ->
    - dungeon: -> dungeon_event ->
    - else: -> wilderness_event ->
}

->->

= creature
Creature: <>
-> create_creature ->->


= urban_event

{shuffle:
    - Wedding
    - Name-giving day celebrations
    - Public holiday
    - Procession
    - Harvest Festival
    - Festival celebrating a god
    - Celebration of a hero’s return
    - Market day
    - Religious rally
    - Official proclamation
    - Amnesty
    - Sudden storm / gale force winds
    - Election / Change of civic leader
    - Yearly local festival
    - Assassination
    - Performance of a play
    - Musical concert
    - Buskers performance
    - Orator / storyteller
    - Alefest
    - Warrior exhibition
    - Procession of royals
    - Museum exhibition
    - New building being opened
    - Large army passing through town
    - Gridlocked traffic
    - Monster invasion!
    - Conference of Wizards
    - Graduation ceremony
    - Traffic accident
    - Freakish weather event
    - Fire in Building
    - Notable local figure assassinated
    - Public duel
    - Large scale fire
    - Sinkhole opens
    - Local army returning after recent skirmish
    - Co-ordinated attack
    - Protest
    - Flood
    - Martial law enforced (Reason?)
    - Wild magic eruption
    - Military conscription
    - Revolution taking place (scale uncertain)
    - Public Execution
    - Storm
    - Plague
    - Earthquake
    - Dimensional disruption
    - Invading force
}

->->

= dungeon_event
-> dungeon_encounter_table ->
->->

= wilderness_event

{shuffle:
    - Landslide / Avalanche
    - Earthquake
    - Storm
    - Druid gathering
    - Religious pilgrimage
    - Army encamped
    - Sudden storm / gale force winds
    - Overturned cart
    - Flash flood
    - Forest Fire
    - Local humanoids having a festival
    - Solar eclipse
    - Hail (large hailstones?)
    - Hurricane
    - Tribal encounter
    - Animal stampede
    - Tree falls
    - Boulder falls
    - Unseasonable weather
    - Lightning strikes
    - Market
    - Hunting Party
    - Farmers harvesting crops
    - Cart passing
    - Refugees
    - Massed Animals
    - Toll demanded
    - Distressed -> create_npc ->
    - Besieged settlement
    - Come across structure
    - Battle in progress
    - Beast / Monster carcass
    - Monster - easy encounter
    - Monster - easy encounter
    - Monster - medium encounter
    - Monster - medium encounter
    - Monster - hard encounter
    - Monster - deadly encounter
    - Volcanic eruption
    - Plague (insect / vermin)
    - Interdimensional Rift
    - Army going to war
    - Sinkhole Appears
    - Appearance of Tyrant in the area
    - Savage raiding party
    - Marauding monster attacking village
    - Undead awakening
    - -> unmarked_settlement_table ->
    - -> unmarked_settlement_table ->
    - -> unmarked_settlement_table ->
}
->->
