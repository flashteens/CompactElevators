# <INNER FUNCTION, EXECUTED BY A SINGLE PLAYER (as @s at @s). DO NOT USE THIS ON ANY OTHER CASES!>
# Only executed if either tag FtmcElev2GoUpwardCond or tag FtmcElev2GoDownwardCond exists for the player.

# Find the session that binds this player
scoreboard players operation #_ftglobaltmp ftelev2_sessid = @s ftelev2_sessid
execute as @e[type=armor_stand,scores={ftelev2_sessid=1..}] run scoreboard players set @s ftelev2_sid_diff 200000000
execute as @e[type=armor_stand,scores={ftelev2_sessid=1..}] run scoreboard players operation @s ftelev2_sid_diff = #_ftglobaltmp ftelev2_sessid
execute as @e[type=armor_stand,scores={ftelev2_sessid=1..}] run scoreboard players operation @s ftelev2_sid_diff -= @s ftelev2_sessid

# If not found, then restore the session.
execute unless entity @e[type=armor_stand,scores={ftelev2_sid_diff=0}] run function ftmc:elevator/v2/open_session
