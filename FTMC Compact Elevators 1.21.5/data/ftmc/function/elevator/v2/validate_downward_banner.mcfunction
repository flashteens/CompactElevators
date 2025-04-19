tag @s remove tmp_FtmcEv2ValidBanner

# Downward
execute if block ~ ~1 ~ minecraft:red_wall_banner{patterns:[{color: "white", pattern: "minecraft:rhombus"}, {color: "red", pattern: "minecraft:stripe_middle"}, {color: "red", pattern: "minecraft:half_horizontal"}]} run tag @s add tmp_FtmcEv2ValidBanner

# Bidirectional
execute if block ~ ~1 ~ minecraft:green_wall_banner{patterns:[{color: "red", pattern: "minecraft:gradient_up"}, {color: "white", pattern: "minecraft:rhombus"}, {color: "brown", pattern: "minecraft:stripe_middle"}]} run tag @s add tmp_FtmcEv2ValidBanner
