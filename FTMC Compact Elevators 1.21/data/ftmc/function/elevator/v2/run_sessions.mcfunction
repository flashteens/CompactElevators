# Sync session scoreboard values with the corresponding players

execute as @e[type=armor_stand,tag=FtmcElev2Session] at @s run function ftmc:elevator/v2/run_session_inner
