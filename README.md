# Summary
This mod introduces more types of slayers and allows for them to be recruited earlier.

There are now 3 distinct varieties of slayers, recruitable at 3 ranks of the Slayer Shrine.

Slayers are intended to provide some melee flanking capability and early handing of larger entities. They are less powerful than they were, but are also cheaper to build and maintain. They cannot take a charge.

Troll Slayers are intended to provide melee flanking capabilities, and protection vs cavalry/monsters. They are slightly more powerful than original slayers, but more expensive. They also feature charge defence vs large and have a small amount of physical resistance, while retaining minor missile deflection.

Giant Slayers are intended to provide powerful armor penetration. They are armor piercing with a large bonus vs large, but do not have any missile resistance. They also feature charge defence vs large and a small amount of physical resistance.

# Construction
The **land_units** table contains most of the stats for units, including the original slayer (wh_main_dwf_inf_slayers).

This links to **main_units**, which seems to be where the campaign specific statistics are applied. Things like cost and some of the building requirements (building requirements looks to be broken into two parts, actual requirements (i.e. Slayer Shrine) + additional (Armoury))).

It also links to **battle_entities**, which deals with some other statistics specific to battles, like speed and whatnot.

Finally, the **land_units** table also links to the weapon the unit wields, which determines damage (and bonuses vs large and whatnot).

**land_units** also contains a column called **attribute_group**, which determines the special (non-skill) properties of the unit, like charge defence vs large for the Dragonback Slayers.

**campaign_map_attrition_unit_immunities** is where you need to set attrition immunity (unsurprisingly).

## Hit Points
Hit points appear to be calculated by 

```
total_hp = battle_entities.hit_points * main_units.num_men + land_units.bonus_hit_points * main_units.num_men
```

This value is the maximum HP the unit can have when the game is set to Ultra unit size. It looks like it applies a scaling factor down for unit sizes less than Ultra.

## Buildings
Buildings are defined in the **building_levels**, **building_chains**, **building_culture_variant** and **building_units_allowed** tables.

**building_culture_variant** contains the short name (i.e. Slayer Shrine) and links to both long and short flavour descriptions.

**building_levels** contains the campaign cost, turn construction time, settlement requirements and whatnot.

**building_chains** links a chain of buildings together (i.e. all the slayer buildings).

**building_upgrades_junction** is required or you get a crash because the game doesnt know how to slot the buildings together

## AI
New units need to be have their quality stated in ?

AI needs to be made aware of buildings with **cai_construction_system_building_values**.

# Building
You can use the `/scripts/build.ps1` file to build a new pack file with the current version. It will also open the Pack File Manager with that file.

Then you add the directories from `/assembly_kit/working_data` that you need (like db, or text).

If you're going to release the mod, you'll need to clean it and remove everything that you didn't change/add (the export from the Assembly Kit includes the entire table, not just the changed entities).

# Change Notes

# Ideas
First set of slayers available at tier 2
Cheaper, but weaker
New tier to slayer building

Second tier of slayers available at tier 3
Similar to old slayers + charge defence and a decent bonus vs large

Third tier of slayers available at tier 4
Armor piercing

Tier 2 and 3 add 1 experience rank for recruitment

Slayer Neophytes -> Troll Slayers -> Giant Slayers

Giant Slayers require the Armory (for their Two Handed Axes).

Slayer Neophytes
* Reduce charge
* Reduce cost
* Reduce weapon damage
* No bonus vs large
* 10% physical resistance
* move to 1 tier lower (new slayer building, Small Slayer Shrine)
* maybe make them similar to miners (atk/defence) but faster with charge bonus and more weapon damage
* tune dragonback down as well, but keep their charge defence vs large

Troll Slayers
* Charge defence vs large
* Same cost as existing slayers
* Slightly increase charge
* Slightly increase weapon damage
* 15% physical resistance
* Smaller numbers but more HP

Dragon Slayers
* Even smaller numbers
* 20% physical resistance
* Greataxe
* Armor piercing
* Bonus vs large
* No missile defence

Great Slayer Shrine available at Tier 1, with 4 levels. Each level gives access to Slayers one tier earlier than normal (i.e. Neophytes at Tier 1, Troll Slayers at Tier 2, Giant Slayers at Tier 3)
Has appropriate garrison.
Tier 2-3 add experience (1 pip each), maybe 3 also adds slight upkeep reduction (10%?)
Tier 4 adds upkeep reduction to all slayers + experience + something else?
Normal corruption reduction too.