tag @s remove tmp_FtmcEv2ValidBanner

# Downward
execute if block ~ ~1 ~ minecraft:red_wall_banner{Patterns:[{Color:0,Pattern:"mr"},{Color:14,Pattern:"ms"},{Color:14,Pattern:"hh"}]} run tag @s add tmp_FtmcEv2ValidBanner

# Bidirectional
execute if block ~ ~1 ~ minecraft:green_wall_banner{Patterns:[{Color:14,Pattern:"gru"},{Color:0,Pattern:"mr"},{Color:12,Pattern:"ms"}]} run tag @s add tmp_FtmcEv2ValidBanner
