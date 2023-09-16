Config                              = Config or {}

-- Misc
Config.Debug        				= true   	-- If you think something is not working, you can set 'Config.Debug' to true. It will then print a lot of debug information in your console

-- Lap dance 
Config.LegMoney                     = 1000     -- Little easter egg for your player, will add an accessory "Leg money" to the stripper if the player has more than 'Config.LegMoney' in cash. Set to a huge value if you don't want this
Config.Nudity                       = false      -- Set to true if you want the stripper to be topless (Only for player above 'Config.NudityAge')
Config.NudityAge                    = 21        -- (QBCore only!!) Player age restriction. If underage and 'Config.Nudity' is set to true, the stripper won't be topless. Set to 0 if you don't want age restriction

-- Blip
Config.Blip                         = true         -- Set to false if you don't want the blip on the map
Config.BlipName                     = "Strip-Club" -- Blip name
Config.BlipStripclub = {
	Sprite = 121,  -- Sprite list can be found here: https://docs.fivem.net/docs/game-references/blips/
	Colour = 50,   -- Color list in the same URL as above
	Display = 6,   -- Explanation here: https://docs.fivem.net/natives/?_0x9029B2F3DA924928
	Scale = 0.7    -- Self explanatory, let you set the scale of the blip
}
Config.BlipCoord					= vector3(117.04, -1294.8, 29.27)               -- If you want to move the blip on the map, change this.

-- Club configuration
Config.Npc = {model = 'cs_paper', position = vector4(117.57, -1295.71, 28.27, 303.03)}
Config.ChangingRoom = vector3(111.86, -1297.82, 29.27)
Config.Chairs = {
	{go = vector3(118.75, -1301.97, 29.27), sit = vector3(119.11, -1302.55, 28.7), heading = 29.78},
	{go = vector3(116.71, -1303.41, 29.27), sit = vector3(116.98, -1303.74, 28.7), heading = 29.78},
	{go = vector3(114.55, -1304.54, 29.27), sit = vector3(114.82, -1305.05, 28.7), heading = 29.78},
	{go = vector3(112.7, -1305.62, 29.27), sit = vector3(112.97, -1306.14, 28.7), heading = 29.78},
	{go = vector3(114.65, -1300.28, 29.27), sit = vector3(114.33, -1299.81, 28.7), heading = 208.57},
	{go = vector3(112.71, -1301.38, 29.27), sit = vector3(112.44, -1300.9, 28.7), heading = 208.57},
	{go = vector3(111.0, -1302.35, 29.27), sit = vector3(110.67, -1301.93, 28.7), heading = 208.57},
}

-- Stripper dances
Config.Dances = {
	["lapdance"] = {
		price = 300,
		moves = {
			{dict = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f", partner = "ld_girl_a_song_a_p1_m", time = 40000},
			{dict = "mini@strip_club@lap_dance@ld_girl_a_song_a_p2", anim = "ld_girl_a_song_a_p2_f", partner = "ld_girl_a_song_a_p2_m", time = 40000},
			{dict = "mini@strip_club@lap_dance@ld_girl_a_song_a_p3", anim = "ld_girl_a_song_a_p3_f", partner = "ld_girl_a_song_a_p3_m", time = 40000},
		}
	},
	["privdance"] = {
		price = 120,
		moves = {
			{dict = "mini@strip_club@private_dance@part1", anim = "priv_dance_p1", time = 22000, orientation = "front"},
			{dict = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2", time = 30000, orientation = "front"},
			{dict = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3", time = 25000, orientation = "front"},
		}
	},
	["doubledance"] = {
		price = 700,
		moves = {
			{dict = "mini@strip_club@lap_dance_2g@ld_2g_p1", anim = "ld_2g_p1_s1", partner = "ld_2g_p1_m", anim2 = "ld_2g_p1_s2", time = 40000},
			{dict = "mini@strip_club@lap_dance_2g@ld_2g_p2", anim = "ld_2g_p2_s1", partner = "ld_2g_p2_m", anim2 = "ld_2g_p2_s2", time = 40000},
			{dict = "mini@strip_club@lap_dance_2g@ld_2g_p3", anim = "ld_2g_p3_s1", partner = "ld_2g_p3_m", anim2 = "ld_2g_p3_s2", time = 40000},
		}
	},
}
-- Dancers locations
Config.Dancers = {
	{type = "pole", pos = vector3(112.63, -1286.75, 28.56), heading = 302.45, model = 's_f_y_stripper_02'},
	{type = "double", pos = vector3(108.06, -1290.75, 28.36), heading = 302.45, model = 's_f_y_stripper_01'},
	{type = "ground", pos = vector3(103.31, -1292.48, 29.36), heading = 302.45, model = 's_f_y_stripper_01'},
	{type = "pole", pos = vector3(104.19, -1293.99, 29.36), heading = 302.45, model = 's_f_y_stripper_02'},
	{type = "pole", pos = vector3(102.25, -1290.62, 29.36), heading = 302.45, model = 's_f_y_stripper_02'},
}
