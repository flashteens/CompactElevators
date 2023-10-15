# Only executable from a player.

# Generate the next ID
scoreboard players add #NEXT_FTELEV2SID ftelev2_sessid 1

# Prevent #NEXT_FTELEV2SID.ftelev2_sessid from integer overflow.
execute if score #NEXT_FTELEV2SID ftelev2_sessid matches 100000001.. run scoreboard players set #NEXT_FTELEV2SID ftelev2_sessid 1

# Grant the new ID to the player.
scoreboard players operation @s ftelev2_sessid = #NEXT_FTELEV2SID ftelev2_sessid

# Summon a new hidden armor_stand (to be used as a "hidden vehicle") and also grant the new ID to it.
# ftelev2_sessid = -1 is for the state "under initialization". Once initialized, it will be changed to a positive value.
execute at @s run summon armor_stand ~ ~ ~ {NoAI:1b,Invulnerable:1b,Silent:1b,Invisible:1b,Tags:["FtmcElev2Session"]}
execute at @s run scoreboard players set @e[type=armor_stand,tag=FtmcElev2Session,distance=..0.1,limit=1,sort=nearest] ftelev2_sessid -1

# Apply tags FtmcElev2GoUpwardCond and FtmcElev2GoDownwardCond to the armor_stand.
execute if entity @s[tag=FtmcElev2GoUpwardCond] run tag @e[type=armor_stand,tag=FtmcElev2Session,scores={ftelev2_sessid=-1},limit=1] add FtmcElev2GoUpwardCond
execute if entity @s[tag=FtmcElev2GoDownwardCond] run tag @e[type=armor_stand,tag=FtmcElev2Session,scores={ftelev2_sessid=-1},limit=1] add FtmcElev2GoDownwardCond

# Syncronize the armor_stand's rotation to the player.
tp @e[type=armor_stand,tag=FtmcElev2Session,scores={ftelev2_sessid=-1},limit=1] @s

# Apply the new session ID finally.
scoreboard players operation @s ftelev2_sessid = #NEXT_FTELEV2SID ftelev2_sessid
scoreboard players operation @e[type=armor_stand,tag=FtmcElev2Session,scores={ftelev2_sessid=-1},limit=1] ftelev2_sessid = #NEXT_FTELEV2SID ftelev2_sessid
