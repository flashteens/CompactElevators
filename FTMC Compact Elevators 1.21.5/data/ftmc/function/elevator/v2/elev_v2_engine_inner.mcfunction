#As: a player
#At: undefined

# player elevator scoreboard initialization
execute as @s[tag=!FtmcElev2HasInit] run scoreboard players operation @s ftelev2_njump0 = @s ftelev2_njump
execute as @s[tag=!FtmcElev2HasInit] run scoreboard players operation @s ftelev2_nsneak0 = @s ftelev2_nsneak
tag @s[tag=!FtmcElev2HasInit] add FtmcElev2HasInit

# Check if the player is on a valid elevator block (for upward direction)
execute at @s if block ~ ~2 ~ #minecraft:impermeable run tag @s add FtmcElev2OnUpValidBlock
execute at @s unless block ~-0.3 ~2 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute at @s unless block ~-0.3 ~2 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute at @s unless block ~0.3 ~2 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute at @s unless block ~0.3 ~2 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute as @s[tag=FtmcElev2GoUpwardCond] at @s if block ~ ~1 ~ #minecraft:impermeable run tag @s add FtmcElev2OnUpValidBlock

# Check if the player is on a valid elevator block (for downward direction)
execute at @s if block ~ ~-1 ~ #minecraft:impermeable run tag @s add FtmcElev2OnDnValidBlock
execute at @s unless block ~-0.3 ~-1 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute at @s unless block ~-0.3 ~-1 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute at @s unless block ~0.3 ~-1 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute at @s unless block ~0.3 ~-1 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock

# Check if the player is on a valid elevator entry (when not riding inside)
tag @s add tmp_FtmcEv2ValidBanner
execute as @s[tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond] at @s run function ftmc:elevator/v2/validate_upward_banner
tag @s[tag=!tmp_FtmcEv2ValidBanner] remove FtmcElev2OnUpValidBlock
execute as @s[tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond] at @s run function ftmc:elevator/v2/validate_downward_banner
tag @s[tag=!tmp_FtmcEv2ValidBanner] remove FtmcElev2OnDnValidBlock
tag @s remove tmp_FtmcEv2ValidBanner

# [Since 20220801] Do not start the session if the player is in Spectator mode.
execute as @s[tag=FtmcElev2OnUpValidBlock,gamemode=spectator] run tag @s remove FtmcElev2OnUpValidBlock
execute as @s[tag=FtmcElev2OnDnValidBlock,gamemode=spectator] run tag @s remove FtmcElev2OnDnValidBlock

# [Since 20220801] Refresh the scoreboard value of 'ArrivalFloorY' for custom arrival title implementation
execute at @s run function ftmc:elevator/v2/refresh_arrival_floor_y

# Set up the condition to start a teleportation session, and then start the session.
execute as @s[tag=FtmcElev2OnUpValidBlock,tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond] at @s if score @s ftelev2_njump > @s ftelev2_njump0 run tag @s add FtmcElev2_tmpReadyToAddGoUpCond
execute as @s[tag=FtmcElev2OnDnValidBlock,tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond] at @s if score @s ftelev2_nsneak > @s ftelev2_nsneak0 run tag @s add FtmcElev2_tmpReadyToAddGoDnCond
tag @s[tag=FtmcElev2_tmpReadyToAddGoUpCond] add FtmcElev2GoUpwardCond
tag @s[tag=FtmcElev2_tmpReadyToAddGoDnCond] add FtmcElev2GoDownwardCond
execute as @s[tag=FtmcElev2_tmpReadyToAddGoUpCond] at @s run function ftmc:elevator/v2/open_session
execute as @s[tag=FtmcElev2_tmpReadyToAddGoDnCond] at @s run function ftmc:elevator/v2/open_session
tag @s remove FtmcElev2_tmpReadyToAddGoUpCond
tag @s remove FtmcElev2_tmpReadyToAddGoDnCond

# Restore the session for those players who somehow lost the session (ex: due to re-connecting to multiplayer during an elevator ride).
execute as @s[tag=FtmcElev2GoUpwardCond] at @s run function ftmc:elevator/v2/restore_session
execute as @s[tag=FtmcElev2GoDownwardCond] at @s run function ftmc:elevator/v2/restore_session

# Run a teleportation tick for every player who has his corresponding session (armor_stand entity).
# For those players in the session, their tags FtmcElev2GoUpwardCond and FtmcElev2GoDownwardCond will be overriden before the teleportation is executed.
#function ftmc:elevator/v2/run_sessions
# ^ MOVED TO OUTER SCOPE OF elev_v2_engine.mcfunction.

# clear temporary conditional tags
# tag @s[tag=!FtmcElev2OnUpValidBlock] remove FtmcElev2GoUpwardCond
# tag @s[tag=!FtmcElev2OnDnValidBlock] remove FtmcElev2GoDownwardCond
tag @s remove FtmcElev2OnUpValidBlock
tag @s remove FtmcElev2OnDnValidBlock

# Sync the previous state of "# of jumps" and "# of sneaks".
execute run scoreboard players operation @s ftelev2_njump0 = @s ftelev2_njump
execute run scoreboard players operation @s ftelev2_nsneak0 = @s ftelev2_nsneak
