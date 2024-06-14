# Apply a temporary "slow falling" effect (to be used during each elevator ride)
# Target: the player

# Make the player's slow falling effect temporary unless he has the same effect already.
execute unless entity @s[nbt={ActiveEffects:[{Id:28b}]}] run tag @s add FtmcElev2DontKeepEffect28
effect give @s[tag=FtmcElev2DontKeepEffect28] minecraft:slow_falling 120 0 true
