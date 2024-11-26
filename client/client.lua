function DisplayHelpText(text)
    SetTextScale(0.35, 0.35)
    SetTextColor(255, 255, 255, 255)
    SetTextCentre(true)
    SetTextDropshadow(1, 0, 0, 0, 200)
    SetTextFontForCurrentCommand(1)
    DisplayText(CreateVarString(10, "LITERAL_STRING", text), 0.5, 0.8)
end

function IsCampfire(entity)
    for _, hash in ipairs(Config.CampfireModelHashes) do
        if GetEntityModel(entity) == hash then
            return true
        end
    end
    return false
end

function ShowCraftingUI()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openCraftingMenu',
        items = Config.CraftingItems
    })
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local nearbyEntities = GetEntitiesInArea(playerCoords, 2.0)

        for _, entity in ipairs(nearbyEntities) do
            if IsCampfire(entity) then
                DisplayHelpText("Press [E] to craft items")
                if IsControlJustReleased(0, Config.CraftingKeybind) then
                    ShowCraftingUI()
                end
                break
            end
        end
    end
end)

RegisterNetEvent('campfire:playCraftingAnimation')
AddEventHandler('campfire:playCraftingAnimation', function()
    local playerPed = PlayerPedId()

    RequestAnimDict("amb_work@world_human_campfire@female_a@base")
    while not HasAnimDictLoaded("amb_work@world_human_campfire@female_a@base") do
        Citizen.Wait(100)
    end

    TaskPlayAnim(playerPed, "amb_work@world_human_campfire@female_a@base", "base", 8.0, -8.0, -1, 1, 0.0, false, false, false)
    Citizen.Wait(Config.CraftingTime)
    ClearPedTasks(playerPed)
end)

function GetEntitiesInArea(coords, radius)
    local entities = {}
    local handle, entity = FindFirstObject()
    local success

    repeat
        local entityCoords = GetEntityCoords(entity)
        if #(entityCoords - coords) < radius then
            table.insert(entities, entity)
        end
        success, entity = FindNextObject(handle)
    until not success

    EndFindObject(handle)
    return entities
end

RegisterNUICallback('craftItem', function(data, cb)
    TriggerServerEvent('campfire:craftItem', data.item, 'en') -- Default language set to 'en'
    cb('ok')
end)

RegisterNUICallback('closeUI', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)