tag @s remove tmp_FtmcEv2ValidBanner

# Upward
execute if block ~ ~1 ~ minecraft:green_wall_banner{patterns:[{color: "white", pattern: "minecraft:rhombus"}, {color: "green", pattern: "minecraft:stripe_middle"}, {color: "green", pattern: "minecraft:half_horizontal_bottom"}]} run tag @s add tmp_FtmcEv2ValidBanner

# Bidirectional
execute if block ~ ~1 ~ minecraft:green_wall_banner{patterns:[{color: "red", pattern: "minecraft:gradient_up"}, {color: "white", pattern: "minecraft:rhombus"}, {color: "brown", pattern: "minecraft:stripe_middle"}]} run tag @s add tmp_FtmcEv2ValidBanner
