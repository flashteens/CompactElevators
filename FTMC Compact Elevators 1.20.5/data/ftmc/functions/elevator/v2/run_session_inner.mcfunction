# <INNER FUNCTION, EXECUTED BY A SINGLE ARMOR_STAND (as @s at @s). DO NOT USE THIS ON ANY OTHER CASES!>

# Check if the armor_stand is on a valid elevator block (for upward direction)
execute if block ~ ~2 ~ #minecraft:impermeable run tag @s add FtmcElev2OnUpValidBlock
execute unless block ~-0.3 ~2 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute unless block ~-0.3 ~2 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute unless block ~0.3 ~2 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute unless block ~0.3 ~2 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnUpValidBlock
execute if entity @s[tag=FtmcElev2GoUpwardCond] if block ~ ~1 ~ #minecraft:impermeable run tag @s add FtmcElev2OnUpValidBlock

# Check if the armor_stand is on a valid elevator block (for downward direction)
execute if block ~ ~-1 ~ #minecraft:impermeable run tag @s add FtmcElev2OnDnValidBlock
execute unless block ~-0.3 ~-1 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute unless block ~-0.3 ~-1 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute unless block ~0.3 ~-1 ~-0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock
execute unless block ~0.3 ~-1 ~0.3 #minecraft:impermeable run tag @s remove FtmcElev2OnDnValidBlock

# Reverse teleporting direction when detecting obstacles ahead
tag @s[tag=FtmcElev2GoUpwardCond] add FtmcElev2UpAlmostBumps
execute if entity @s[tag=FtmcElev2GoUpwardCond] if block ~ ~3 ~ #minecraft:impermeable run tag @s remove FtmcElev2UpAlmostBumps
execute if entity @s[tag=FtmcElev2GoUpwardCond] if block ~ ~3 ~ #ftmc_elevator:exits run tag @s remove FtmcElev2UpAlmostBumps
execute if entity @s[tag=FtmcElev2GoUpwardCond] if block ~ ~2 ~ #ftmc_elevator:exits run tag @s remove FtmcElev2UpAlmostBumps

tag @s[tag=FtmcElev2GoDownwardCond] add FtmcElev2DnAlmostBumps
execute if entity @s[tag=FtmcElev2GoDownwardCond] if block ~ ~-1 ~ #minecraft:impermeable run tag @s remove FtmcElev2DnAlmostBumps
execute if entity @s[tag=FtmcElev2GoDownwardCond] if block ~ ~-1 ~ #ftmc_elevator:exits run tag @s remove FtmcElev2DnAlmostBumps

tag @s[tag=FtmcElev2UpAlmostBumps] remove FtmcElev2GoUpwardCond
tag @s[tag=FtmcElev2UpAlmostBumps] add FtmcElev2GoDownwardCond
tag @s remove FtmcElev2UpAlmostBumps

tag @s[tag=FtmcElev2DnAlmostBumps] remove FtmcElev2GoDownwardCond
tag @s[tag=FtmcElev2DnAlmostBumps] add FtmcElev2GoUpwardCond
tag @s remove FtmcElev2DnAlmostBumps

# Run a teleportation tick for each session
execute if entity @s[tag=FtmcElev2GoUpwardCond] run teleport @s ~ ~1.00 ~
execute if entity @s[tag=FtmcElev2GoDownwardCond] run teleport @s ~ ~-0.60 ~

# Find the player that bind this session
scoreboard players operation #_ftglobaltmp ftelev2_sessid = @s ftelev2_sessid
execute as @a[scores={ftelev2_sessid=1..}] run scoreboard players set @s ftelev2_sid_diff 200000000
execute as @a[scores={ftelev2_sessid=1..}] run scoreboard players operation @s ftelev2_sid_diff = #_ftglobaltmp ftelev2_sessid
execute as @a[scores={ftelev2_sessid=1..}] run scoreboard players operation @s ftelev2_sid_diff -= @s ftelev2_sessid

# Teleport the corresponding player to the armor_stand
tp @a[scores={ftelev2_sessid=1..,ftelev2_sid_diff=0}] @s
execute as @a[scores={ftelev2_sessid=1..,ftelev2_sid_diff=0}] run function ftmc:elevator/v2/prevent_damage

# End a session on necessary
tag @s[tag=!FtmcElev2OnUpValidBlock] remove FtmcElev2GoUpwardCond
tag @s[tag=!FtmcElev2OnDnValidBlock] remove FtmcElev2GoDownwardCond

# Clear temporary conditional tags
tag @s remove FtmcElev2OnUpValidBlock
tag @s remove FtmcElev2OnDnValidBlock

# Synchronize the player's tags FtmcElev2GoUpwardCond and FtmcElev2GoDownwardCond with the session
execute if entity @s[tag=FtmcElev2GoUpwardCond] run tag @a[scores={ftelev2_sessid=1..,ftelev2_sid_diff=0}] add FtmcElev2GoUpwardCond
execute if entity @s[tag=!FtmcElev2GoUpwardCond] run tag @a[scores={ftelev2_sessid=1..,ftelev2_sid_diff=0}] remove FtmcElev2GoUpwardCond
execute if entity @s[tag=FtmcElev2GoDownwardCond] run tag @a[scores={ftelev2_sessid=1..,ftelev2_sid_diff=0}] add FtmcElev2GoDownwardCond
execute if entity @s[tag=!FtmcElev2GoDownwardCond] run tag @a[scores={ftelev2_sessid=1..,ftelev2_sid_diff=0}] remove FtmcElev2GoDownwardCond

# Kill the session if ended
execute if entity @s[type=armor_stand,tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond] run execute as @a[scores={ftelev2_sessid=1..,ftelev2_sid_diff=0}] run function ftmc:elevator/v2/stop_prevent_damage
kill @s[type=armor_stand,tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond]
