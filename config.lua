Config = {}

Config.Languages = {
    en = {
        required_items = "You don't have the required items",
        crafting_started = "Crafting started"
    },
}

Config.CampfireModelHashes = {
    GetHashKey("p_campfire01x"),
    GetHashKey("p_campfire05x"),
    GetHashKey("p_furnace01x"),
}

Config.CraftingTime = 15000
Config.CraftingKeybind = 0xCEFD9220 -- E key

Config.CraftingItems = {
    {
        name = "consumable_breakfast",
        label = "Breakfast",
        image = "assets/img/consumable_breakfast.png",
        requiredItems = {
            {name = "required_item1", count = 2},
            {name = "required_item2", count = 1}
        }
    },
}