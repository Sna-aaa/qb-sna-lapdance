function CreateNpc()
	RequestModel(Config.Npc.model)
	while not HasModelLoaded(Config.Npc.model) do
		Wait(5)
	end
	local ped = CreatePed(4, GetHashKey(Config.Npc.model), Config.Npc.position.x, Config.Npc.position.y, Config.Npc.position.z, Config.Npc.position.w, false, false)
	SetEntityAsMissionEntity(ped, true, true)
	SetPedHearingRange(ped, 0.0)
	SetPedSeeingRange(ped, 0.0)
	SetPedAlertness(ped, 0.0)
	SetPedFleeAttributes(ped, 0, 0)
	SetBlockingOfNonTemporaryEvents(ped, true)
	SetPedCombatAttributes(ped, 46, true)
	SetPedFleeAttributes(ped, 0, 0)
	SetEntityInvincible(ped, true)
	SetEntityCanBeDamaged(ped, false)
	SetEntityProofs(ped, true, true, true, true, true, true, 1, true)
	FreezeEntityPosition(ped, true)
	SetEntityAsMissionEntity(ped, true, true)

	exports['qb-target']:AddTargetEntity(ped, {
		options = {
			{
				Type = "client",
				event = "qb-lapdance:client:buy",
				icon = "fas fa-xmarks-lines",
				label = Lang:t('LapDanceText', {value = Config.Dances["lapdance"].price}),
				dancetype = "lapdance",
			},
			{
				Type = "client",
				event = "qb-lapdance:client:buy",
				icon = "fas fa-xmarks-lines",
				label = Lang:t('PrivateDanceText', {value = Config.Dances["privdance"].price}),
				dancetype = "privdance",
			},
			{
				Type = "client",
				event = "qb-lapdance:client:buy",
				icon = "fas fa-xmarks-lines",
				label = Lang:t('DoubleDanceText', {value = Config.Dances["doubledance"].price}),
				dancetype = "doubledance",
			},
		},
		distance = 2.0
	})

end

RegisterNetEvent('qb-lapdance:client:buy', function(data)
	TriggerServerEvent('qb-lapdance:buy', data.dancetype)
end)

function CreateBlip()
    	-- Blip Creation
	if Config.Blip then
		local blip = AddBlipForCoord(Config.BlipCoord.x, Config.BlipCoord.y, Config.BlipCoord.z)

		SetBlipSprite (blip, Config.BlipStripclub.Sprite)
		SetBlipDisplay(blip, Config.BlipStripclub.Display)
		SetBlipScale  (blip, Config.BlipStripclub.Scale)
		SetBlipColour (blip, Config.BlipStripclub.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.BlipName)
		EndTextCommandSetBlipName(blip)
	end

end

function GetHeading(Seat, Orientation)
	if Orientation == "front" then
		if Config.Chairs[Seat].heading < 180 then
			return Config.Chairs[Seat].heading + 180
		else
			return Config.Chairs[Seat].heading - 180
		end
	elseif Orientation == "right" then
		if Config.Chairs[Seat].heading > 270 then
			return Config.Chairs[Seat].heading + 90 - 360
		else
			return Config.Chairs[Seat].heading + 90
		end
	elseif Orientation == "left" then
		if Config.Chairs[Seat].heading < 90 then
			return 360 - 90 + Config.Chairs[Seat].heading
		else
			return Config.Chairs[Seat].heading - 90
		end
	else
		return Config.Chairs[Seat].heading
	end
end

function HasMajority(PlayerBirthdate, TodayDate)
	local Birthdate = {}
	local Date = {}

	local index = 1
	for value in string.gmatch(PlayerBirthdate, "[^-]+") do
		Birthdate[index] = value
		index = index + 1
	end

	index = 1
	for value in string.gmatch(TodayDate, "[^-]+") do
		Date[index] = value
		index = index + 1
	end

	local Year = Date[1] - Birthdate[1]
	local Month = Date[2] - Birthdate[2]
	local Day = Date[3] - Birthdate[3]
	
	if Year > Config.NudityAge then
		return true
	elseif Year == Config.NudityAge then
		if Month > 0 then
			return true
		elseif Month == 0 then
			if Day >= 0 then
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end

end

function SetTopless(npc, model, value)
	if value then
		if model == 's_f_y_stripper_01' then
			SetPedComponentVariation(npc, 8, 1) -- No Skirt
			SetPedComponentVariation(npc, 3, 2) -- No Bra
		elseif model == 's_f_y_stripper_02' then
			SetPedComponentVariation(npc, 8, 1) -- No Bra
			SetPedComponentVariation(npc, 3, 0) -- No Jacket
		end
	else
		if model == 's_f_y_stripper_01' then
			--SetPedComponentVariation(npc, 8, 1) -- No Skirt
		elseif model == 's_f_y_stripper_02' then
			SetPedComponentVariation(npc, 8, 0) -- Bra
			SetPedComponentVariation(npc, 3, 0) -- No Jacket
		end
	end
end
