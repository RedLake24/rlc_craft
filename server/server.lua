RegisterServerEvent('campfire:craftItem')
AddEventHandler('campfire:craftItem', function(itemName, language)
    local source = source
    local player = GetPlayerName(source)
    local canCraft = true
    local craftedItem

    for _, item in ipairs(Config.CraftingItems) do
        if item.name == itemName then
            craftedItem = item
            break
        end
    end

    if craftedItem then
        for _, requiredItem in ipairs(craftedItem.requiredItems) do
            local playerHasItem = true
            if not playerHasItem then
                canCraft = false
                break
            end
        end
    else
        canCraft = false
    end

    if canCraft then
        for _, requiredItem in ipairs(craftedItem.requiredItems) do
        end
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Crafting", Config.Languages[language].crafting_started .. " " .. craftedItem.label}
        })

        TriggerClientEvent('campfire:playCraftingAnimation', source)
    else
        TriggerClientEvent('chat:addMessage', source, {
            color = {255, 0, 0},
            multiline = true,
            args = {"Crafting", Config.Languages[language].required_items}
        })
    end
end)