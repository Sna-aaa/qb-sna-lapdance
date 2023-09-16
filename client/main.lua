local QBCore = exports['qb-core']:GetCoreObject()

local StripperNPC
local StripperNPC2
local CurrentSeat
local CurrentType
local PlayerMove = false
local StripperMove = false


-- Initial load
CreateThread(function()	
	CreateBlip()
	CreateNpc()
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
    end
end)

local function SendPlayerToSeat(Seat)
	if Config.Debug then
        print("Send Player to seat", Seat, "At", Config.Chairs[Seat].go.x, Config.Chairs[Seat].go.y, Config.Chairs[Seat].go.z)
    end
	local Player = PlayerPedId()
	TaskGoToCoordAnyMeans(Player, Config.Chairs[Seat].go.x, Config.Chairs[Seat].go.y, Config.Chairs[Seat].go.z, 1.0, 0, 0, 786603, 1.0)
	PlayerMove = true
end

local function CreateStripper(IsAdult, PlayerMoney)
	if Config.Debug then
        print("Create Stripper")
    end

	local model = math.random(1, 2)
	if model == 1 then
		model = 's_f_y_stripper_01'
	else
		model = 's_f_y_stripper_02'
	end
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(20)
	end

	local NPC = CreatePed(4, GetHashKey(model), Config.ChangingRoom.x, Config.ChangingRoom.y, Config.ChangingRoom.z)
	if IsAdult and Config.Nudity then	-- Topless
		SetTopless(NPC, model, true)
	elseif not IsAdult and Config.Nudity then	-- Not Topless
		SetTopless(NPC, model, false)
	elseif not Config.Nudity then	-- Not Topless
		SetTopless(NPC, model, false)
	end

	if PlayerMoney >= Config.LegMoney then
		SetPedComponentVariation(NPC, 9, 1)
	else
		SetPedComponentVariation(NPC, 9, 0)
	end
	return NPC
end

local function SendStripperToSeat(Seat)
	if Config.Debug then
        print("Send Stripper to seat", Seat)
    end

	FreezeEntityPosition(StripperNPC, true)
	RequestAnimDict("mini@strip_club@idles@stripper")
	while not HasAnimDictLoaded("mini@strip_club@idles@stripper") do
		Wait(20)
	end

	TaskPlayAnim(StripperNPC, "mini@strip_club@idles@stripper", "stripper_idle_02", 8.0, -8.0, -1, 0, 0, false, false, false)
	Wait(2000)

	FreezeEntityPosition(StripperNPC, false)
	TaskGoToCoordAnyMeans(StripperNPC, Config.Chairs[Seat].go.x, Config.Chairs[Seat].go.y, Config.Chairs[Seat].go.z, 1.0, 0, 0, 0, 0xbf800000)
	if CurrentType == "doubledance" then
		TaskGoToCoordAnyMeans(StripperNPC2, Config.Chairs[Seat].go.x, Config.Chairs[Seat].go.y, Config.Chairs[Seat].go.z, 1.0, 0, 0, 0, 0xbf800000)		
	end
	StripperMove = true
end

local function AnimateStripper(Seat)
	if Config.Debug then
        print("Animate Stripper on seat", Seat, CurrentType)
    end
	
	FreezeEntityPosition(StripperNPC, true)
	for k, move in pairs(Config.Dances[CurrentType].moves) do
		if Config.Debug then
			print("Anim", k, move.dict, move.anim)
		end

		RequestAnimDict(move.dict)
		while not HasAnimDictLoaded(move.dict) do
			Wait(20)
		end
		local Player = PlayerPedId()
		local pos = GetEntityCoords(Player)
		local head = GetEntityHeading(Player)
		if CurrentType == "lapdance" then
			local netScene4 = CreateSynchronizedScene(pos.x, pos.y, pos.z, vec3(0.0, 0.0, 0.0), 2)
			TaskSynchronizedScene(Player, netScene4, move.dict, move.partner, 1.0, -4.0, 261, 0, 0)
			TaskSynchronizedScene(StripperNPC, netScene4, move.dict, move.anim, 1.0, -4.0, 261, 0, 0)
		elseif CurrentType == "privdance" then
			SetEntityHeading(StripperNPC, GetHeading(Seat, move.orientation))
			TaskPlayAnim(StripperNPC, move.dict, move.anim, 8.0, -8.0, -1, 0, 0, false, false, false)
		elseif CurrentType == "doubledance" then
			local netScene5 = CreateSynchronizedScene(pos.x, pos.y, pos.z, vec3(0.0, 0.0, 0.0), 2)
			TaskSynchronizedScene(Player, netScene5, move.dict, move.partner, 1.0, -4.0, 261, 0, 0)
			TaskSynchronizedScene(StripperNPC, netScene5, move.dict, move.anim, 1.0, -4.0, 261, 0, 0)
			TaskSynchronizedScene(StripperNPC2, netScene5, move.dict, move.anim2, 1.0, -4.0, 261, 0, 0)
		end
		Wait(move.time)		
	end

	--Say goodbye
	if Config.Debug then
		print("Anim Bye Bye")
	end
	SetEntityHeading(StripperNPC, GetHeading(Seat, "front"))
	RequestAnimDict("mini@strip_club@idles@stripper")
	while not HasAnimDictLoaded("mini@strip_club@idles@stripper") do
		Wait(20)
	end
	TaskPlayAnim(StripperNPC, "mini@strip_club@idles@stripper", "stripper_idle_02", 8.0, -8.0, -1, 0, 0, false, false, false)
	if CurrentType == "doubledance" then
		TaskPlayAnim(StripperNPC2, "mini@strip_club@idles@stripper", "stripper_idle_02", 8.0, -8.0, -1, 0, 0, false, false, false)
	end
	Wait(12000)

	FreezeEntityPosition(StripperNPC, false)

	TriggerServerEvent('qb-lapdance:idle')
end

local function ReturnStripper()
	if Config.Debug then
        print("Return Stripper")
    end
	TaskGoToCoordAnyMeans(StripperNPC, Config.ChangingRoom.x, Config.ChangingRoom.y, Config.ChangingRoom.z, 1.0, 0, 0, 0, 0xbf800000)
	if CurrentType == "doubledance" then
		Wait(500)
		TaskGoToCoordAnyMeans(StripperNPC2, Config.ChangingRoom.x, Config.ChangingRoom.y, Config.ChangingRoom.z, 1.0, 0, 0, 0, 0xbf800000)
	end
	Wait(1000)
	--Release player
	local Player = PlayerPedId()
	SetEntityCoords(Player, Config.Chairs[CurrentSeat].go.x, Config.Chairs[CurrentSeat].go.y, Config.Chairs[CurrentSeat].go.z)
	CurrentSeat = false
	CurrentType = false
	ClearPedTasks(Player)

	Wait(11000)
	DeleteEntity(StripperNPC)
	if CurrentType == "doubledance" then
		DeleteEntity(StripperNPC2)
	end
end

local function SeatPlayer(Seat)
	local Player = PlayerPedId()
	SetEntityCoords(Player, Config.Chairs[Seat].sit.x, Config.Chairs[Seat].sit.y, Config.Chairs[Seat].sit.z)
--	FreezeEntityPosition(Player, true)
	SetEntityHeading(Player, Config.Chairs[Seat].heading)
	local offset = GetObjectOffsetFromCoords(Config.Chairs[Seat].sit.x, Config.Chairs[Seat].sit.y, Config.Chairs[Seat].sit.z, Config.Chairs[Seat].heading, 0, 0, 0)
	TaskStartScenarioAtPosition(Player, 'PROP_HUMAN_SEAT_BENCH', offset.x, offset.y, offset.z, Config.Chairs[Seat].heading, 0, true, false)
end

RegisterNetEvent('qb-lapdance:lapdance', function(PlayerMoney, PlayerBirthdate, TodayDate, Seat, Type)
	if Config.Debug then
        print("Lapdance Buy")
    end
	CurrentSeat = Seat
	CurrentType = Type
	local IsAdult = HasMajority(PlayerBirthdate, TodayDate)
	SendPlayerToSeat(Seat)
	StripperNPC = CreateStripper(IsAdult, PlayerMoney)
	if CurrentType == "doubledance" then
		StripperNPC2 = CreateStripper(IsAdult, PlayerMoney)
	end
	SendStripperToSeat(Seat)
end)

--Thread for wait for moves
CreateThread(function()
    while true do
        if PlayerMove and CurrentSeat then
			local Player = PlayerPedId()
			local coords = GetEntityCoords(Player)
			local dist = #(coords - Config.Chairs[CurrentSeat].go)
			if dist < 1.0 then
				PlayerMove = false
				SeatPlayer(CurrentSeat)
			end
    	end
		if StripperMove and CurrentSeat then
			local coords2 = GetEntityCoords(StripperNPC)
			local dist2 = #(coords2 - Config.Chairs[CurrentSeat].go)
			if dist2 < 1.0 then
				StripperMove = false
				AnimateStripper(CurrentSeat)
				ReturnStripper()
			end
		end
		Wait(500)
    end
end) 

-- Create strippers
CreateThread(function()
	for index, dancer in pairs(Config.Dancers) do
		RequestModel(GetHashKey(dancer.model))
		while not HasModelLoaded(GetHashKey(dancer.model)) do
			Wait(10)
		end
	
		local npc = CreatePed(1, GetHashKey(dancer.model), dancer.pos.x, dancer.pos.y, dancer.pos.z, dancer.heading, false, true)
		SetTopless(npc, dancer.model, false)

		FreezeEntityPosition(npc, true)	
		SetEntityHeading(npc, dancer.heading)
		SetEntityInvincible(npc, true)
		SetBlockingOfNonTemporaryEvents(npc, true)
		Wait(math.random(500, 4000))
		if dancer.type == "ground" then
			RequestAnimDict("mini@strip_club@private_dance@part3")
			while not HasAnimDictLoaded("mini@strip_club@private_dance@part3") do
				Wait(100)
			end
			local netScene = CreateSynchronizedScene(dancer.pos.x, dancer.pos.y, dancer.pos.z, vec3(0.0, 0.0, 0.0), 2)
			TaskSynchronizedScene(npc, netScene, "mini@strip_club@private_dance@part3", "priv_dance_p3", 1.0, -4.0, 261, 0, 0)
			SetSynchronizedSceneLooped(netScene, 1)
	
		elseif dancer.type == "pole" then
			RequestAnimDict("mini@strip_club@pole_dance@pole_dance3")
			while not HasAnimDictLoaded("mini@strip_club@pole_dance@pole_dance3") do
				Wait(100)
			end
			local netScene2 = CreateSynchronizedScene(dancer.pos.x, dancer.pos.y, dancer.pos.z, vec3(0.0, 0.0, 0.0), 2)
			TaskSynchronizedScene(npc, netScene2, "mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", 1.0, -4.0, 261, 0, 0)
			SetSynchronizedSceneLooped(netScene2, 1)
	
		elseif dancer.type == "double" then
			local npc2 = CreatePed(1, GetHashKey(dancer.model), dancer.pos.x, dancer.pos.y, dancer.pos.z, dancer.heading, false, true)
			SetPedComponentVariation(npc2, 8, 2) -- Not Topless
	
			RequestAnimDict("mini@strip_club@lap_dance_2g@ld_2g_p1")
			while not HasAnimDictLoaded("mini@strip_club@lap_dance_2g@ld_2g_p1") do
				Wait(100)
			end
			
			local netScene3 = CreateSynchronizedScene(dancer.pos.x, dancer.pos.y, dancer.pos.z, vec3(0.0, 0.0, 0.0), 2)
			TaskSynchronizedScene(npc, netScene3, "mini@strip_club@lap_dance_2g@ld_2g_p1", "ld_2g_p1_s1", 1.0, -4.0, 261, 0, 0)
			TaskSynchronizedScene(npc2, netScene3, "mini@strip_club@lap_dance_2g@ld_2g_p1", "ld_2g_p1_s2", 1.0, -4.0, 261, 0, 0)
			FreezeEntityPosition(npc2, true)	
			SetEntityHeading(npc2, dancer.heading)
			SetEntityInvincible(npc2, true)
			SetBlockingOfNonTemporaryEvents(npc2, true)
			SetSynchronizedSceneLooped(netScene3, 1)
		end
	end
end)
