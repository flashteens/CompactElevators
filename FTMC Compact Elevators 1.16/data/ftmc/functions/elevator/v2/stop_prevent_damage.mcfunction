# Remove the temporary "slow falling" effect (to be used after each elevator ride)
# Target: the player

# Remove the player's slow falling effect unless it's not considered to be temporary.
# See also: prevent_damage.mcfunction
effect clear @s[tag=FtmcElev2DontKeepEffect28] minecraft:slow_falling
tag @s remove FtmcElev2DontKeepEffect28
