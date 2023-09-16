local QBCore = exports['qb-core']:GetCoreObject()
local OccupiedSeats = {}

local function GetSeat()
    for i, v in pairs(Config.Chairs) do
        if not OccupiedSeats[i] then
            return i
        end
    end
    return false
end

RegisterServerEvent('qb-lapdance:buy', function(type)
    if Config.Debug then
        print("Lapdance Buy")
    end
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerMoney = Player.PlayerData.money["cash"]
    local PlayerBirthdate = Player.PlayerData.charinfo.birthdate
    local TodayDate = os.date("%Y-%m-%d")

    local cost = Config.Dances[type].price
    if PlayerMoney >= cost then
        local seat = GetSeat()
        if seat then
            Player.Functions.RemoveMoney("cash", cost)
            OccupiedSeats[seat] = true
            TriggerClientEvent('QBCore:Notify', src, Lang:t("BoughtLapdance"), "success", 1700)
            TriggerClientEvent('qb-lapdance:lapdance', src, PlayerMoney, PlayerBirthdate, TodayDate, seat, type)
        else
            TriggerClientEvent('QBCore:Notify', src, Lang:t("StripperActive"), "error", 1700)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t("NotEnoughMoney"), "error", 1700)
    end
end)
