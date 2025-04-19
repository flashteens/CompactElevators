#As/At: Player

# Initialize the Y-coord values
execute unless entity @s[scores={ftelev2_y0=-10000..}] run scoreboard players set @s ftelev2_y0 -10000
execute unless entity @s[scores={ftelev2_y1=-10000..}] run scoreboard players set @s ftelev2_y1 -10000

# Specify 'ftelev2_y1' to be the player's Y coordinate value.
execute store result score @s ftelev2_y1 run data get entity @s Pos[1] 1

# Set current Y to -10000 if not on a valid elevator structure
execute if entity @s[tag=!FtmcElev2OnUpValidBlock,tag=!FtmcElev2OnDnValidBlock,tag=!FtmcElev2GoUpwardCond,tag=!FtmcElev2GoDownwardCond] run scoreboard players set @s ftelev2_y1 -10000
execute if entity @s[gamemode=spectator] run scoreboard players set @s ftelev2_y1 -10000

# Set 'ArrivalFloorY' to current Y coordinate value when it is just changed (i.e. the "rising edge" scenario)
# Otherwise reset the value of 'ArrivalFloorY'.
scoreboard players reset @s ArrivalFloorY
execute if entity @s[scores={ftelev2_y1=-9999..}] unless score @s ftelev2_y1 = @s ftelev2_y0 run scoreboard players operation @s ArrivalFloorY = @s ftelev2_y1

# Set previous Y to current Y to be used on the next tick
scoreboard players operation @s ftelev2_y0 = @s ftelev2_y1
