# player elevator scoreboard initialization
execute as @a[tag=!FtmcElev2HasInit] run scoreboard players operation @s ftelev2_njump0 = @s ftelev2_njump
execute as @a[tag=!FtmcElev2HasInit] run scoreboard players operation @s ftelev2_nsneak0 = @s ftelev2_nsneak
tag @a[tag=!FtmcElev2HasInit] add FtmcElev2HasInit

# Check if the player is on a valid elevator block (for upward direction)
execute as @a at @s if block ~ ~2 ~ #minecraft:impermeable run tag @s add FtmcElev2OnUpValidBlock
execute as @a at @s unless block ~-0.3 ~2 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute as @a at @s unless block ~-0.3 ~2 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute as @a at @s unless block ~0.3 ~2 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute as @a at @s unless block ~0.3 ~2 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute as @a[tag=FtmcElev2GoUpwardCond] at @s if block ~ ~1 ~ #minecraft:impermeable run tag @s add FtmcElev2OnUpValidBlock

# Check if the player is on a valid elevator block (for downward direction)
execute as @a at @s if block ~ ~-1 ~ #minecraft:impermeable run tag @s add FtmcElev2OnDnValidBlock
execute as @a at @s unless block ~-0.3 ~-1 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute as @a at @s unless block ~-0.3 ~-1 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute as @a at @s unless block ~0.3 ~-1 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute as @a at @s unless block ~0.3 ~-1 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock

# Check if the player is on a valid elevator entry (when not riding inside)
tag @a add tmp_FtmcEv2ValidBanner
execute as @a[tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond] at @s run function ftmc:elevator/v2/validate_upward_banner
tag @a[tag=!tmp_FtmcEv2ValidBanner] remove FtmcElev2OnUpValidBlock
execute as @a[tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond] at @s run function ftmc:elevator/v2/validate_downward_banner
tag @a[tag=!tmp_FtmcEv2ValidBanner] remove FtmcElev2OnDnValidBlock
tag @a remove tmp_FtmcEv2ValidBanner

# Set up teleportation conds
execute as @a[tag=FtmcElev2OnUpValidBlock,tag=!FtmcElev2GoDownwardCond] at @s if score @s ftelev2_njump > @s ftelev2_njump0 run tag @s add FtmcElev2GoUpwardCond
execute as @a[tag=FtmcElev2OnDnValidBlock,tag=!FtmcElev2GoUpwardCond] at @s if score @s ftelev2_nsneak > @s ftelev2_nsneak0 run tag @s add FtmcElev2GoDownwardCond

# Reverse teleporting direction when detecting obstacles ahead
tag @a[tag=FtmcElev2GoUpwardCond] add FtmcElev2UpAlmostBumps
execute as @a[tag=FtmcElev2GoUpwardCond] at @s if block ~ ~3 ~ #minecraft:impermeable run tag @s remove FtmcElev2UpAlmostBumps
execute as @a[tag=FtmcElev2GoUpwardCond] at @s if block ~ ~3 ~ #ftmc_elevator:exits run tag @s remove FtmcElev2UpAlmostBumps
execute as @a[tag=FtmcElev2GoUpwardCond] at @s if block ~ ~2 ~ #ftmc_elevator:exits run tag @s remove FtmcElev2UpAlmostBumps

tag @a[tag=FtmcElev2GoDownwardCond] add FtmcElev2DnAlmostBumps
execute as @a[tag=FtmcElev2GoDownwardCond] at @s if block ~ ~-1 ~ #minecraft:impermeable run tag @s remove FtmcElev2DnAlmostBumps
execute as @a[tag=FtmcElev2GoDownwardCond] at @s if block ~ ~-1 ~ #ftmc_elevator:exits run tag @s remove FtmcElev2DnAlmostBumps

tag @a[tag=FtmcElev2UpAlmostBumps] remove FtmcElev2GoUpwardCond
tag @a[tag=FtmcElev2UpAlmostBumps] add FtmcElev2GoDownwardCond
tag @a remove FtmcElev2UpAlmostBumps

tag @a[tag=FtmcElev2DnAlmostBumps] remove FtmcElev2GoDownwardCond
tag @a[tag=FtmcElev2DnAlmostBumps] add FtmcElev2GoUpwardCond
tag @a remove FtmcElev2DnAlmostBumps

# run a teleportation tick
execute as @a[tag=FtmcElev2GoUpwardCond] at @s positioned ~ ~ ~ run teleport @s ~ ~1.00 ~
execute as @a[tag=FtmcElev2GoDownwardCond] at @s positioned ~ ~ ~ run teleport @s ~ ~-0.40 ~

# clear temporary conditional tags
tag @a[tag=!FtmcElev2OnUpValidBlock] remove FtmcElev2GoUpwardCond
tag @a[tag=!FtmcElev2OnDnValidBlock] remove FtmcElev2GoDownwardCond
tag @a remove FtmcElev2OnUpValidBlock
tag @a remove FtmcElev2OnDnValidBlock

# Sync the previous state of "# of jumps" and "# of sneaks".
execute as @a run scoreboard players operation @s ftelev2_njump0 = @s ftelev2_njump
execute as @a run scoreboard players operation @s ftelev2_nsneak0 = @s ftelev2_nsneak