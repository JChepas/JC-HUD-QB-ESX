local login = false -- PREVENTS HUD FROM VIEWING WITHOUT SELECTING THE PLAYER CHARACTER -- 

if Config.Framework == "esx" then
    ESX = exports['es_extended']:getSharedObject()
elseif Config.Framework == "qb" then
    QBCore = exports['qb-core']:GetCoreObject()
end

if Config.UseCarHud then
    -- EJECTS EACH PLAYER FROM THE CAR --
    RegisterServerEvent('Lzr_hud:server:EjectPlayer')
    AddEventHandler('Lzr_hud:server:EjectPlayer', function(table, velocity)
    for i=1, #table do
            if table[i] then
                TriggerClientEvent("Lzr_hud:client:EjectPlayer", table[i], velocity)
            end
        end
    end)
end

if Config.UsePlayerStats then
    -- GETS PLAYER PING --
    RegisterServerEvent("Lzr_hud:server:GetPlayerPing", function()
        local src = source
        local PlayerPing = GetPlayerPing(src)
        TriggerClientEvent("Lzr_hud:client:GetPlayerPing", src, PlayerPing)
    end)


    if Config.Framework == "esx" then
        -- GETS PLAYER MONEY FOR ESX --
        RegisterServerEvent("Lzr_hud:server:GetPlayerMoney", function()
            local src = source
            local xPlayer = ESX.GetPlayerFromId(src)
            if not xPlayer then return end
            local PlayerBank = xPlayer.getAccount('bank').money
            local PlayerCash = xPlayer.getAccount('money').money
    
            TriggerClientEvent("Lzr_hud:client:GetPlayerMoney", src, PlayerCash, PlayerBank)
        end)
    elseif Config.Framework == "qb" then
        -- GETS PLAYER MONEY FOR QBCORE --
        RegisterServerEvent("Lzr_hud:server:GetPlayerMoney", function()
            local src = source
            local xPlayer = QBCore.Functions.GetPlayer(src)
            if not xPlayer then return end
            local PlayerBank = xPlayer.PlayerData.money["bank"]
            local PlayerCash = xPlayer.PlayerData.money["cash"]
    
            TriggerClientEvent("Lzr_hud:client:GetPlayerMoney", src, PlayerCash, PlayerBank)
        end)
    end
end