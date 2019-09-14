tag @s remove tmp_FtmcEv2ValidBanner

# Upward
execute if block ~ ~1 ~ minecraft:green_wall_banner{Patterns:[{Color:0,Pattern:"mr"},{Color:13,Pattern:"ms"},{Color:13,Pattern:"hhb"}]} run tag @s add tmp_FtmcEv2ValidBanner

# Bidirectional
execute if block ~ ~1 ~ minecraft:green_wall_banner{Patterns:[{Color:14,Pattern:"gru"},{Color:0,Pattern:"mr"},{Color:12,Pattern:"ms"}]} run tag @s add tmp_FtmcEv2ValidBanner
