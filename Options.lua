local _, addon = ...

-- Generic get and set functions
local function getOption(info)
    local setting = ThreaticusDB.settings
    for i = 1, #info - 1 do  -- Start from 1 as the root name is not included
        setting = setting[info[i]]
    end
    return setting[info[#info]]
end

local function setOption(info, value)
    local setting = ThreaticusDB.settings
    for i = 1, #info - 1 do  -- Start from 1 as the root name is not included
        setting = setting[info[i]]
    end
    setting[info[#info]] = value

    -- Refresh view
    if addon.refreshView then
        addon:refreshView()
    end
end


addon.options = {
    name = "Threaticus",
    handler = addon,
    type = 'group',
    args = {
        damageIndicator = {
            type = 'group',
            name = "Damage Indicator",
            order = 1,
            args = {
                xOffset = {
                    type = 'range',
                    name = "X Offset",
                    desc = "Horizontal offset for the damage indicator",
                    min = -100,
                    max = 100,
                    step = 1,
                    order = 1,
                    get = getOption,
                    set = setOption,
                },
                yOffset = {
                    type = 'range',
                    name = "Y Offset",
                    desc = "Vertical offset for the damage indicator",
                    min = -100,
                    max = 100,
                    step = 1,
                    order = 2,
                    get = getOption,
                    set = setOption,
                },
            },
        },
        spellReductionIndicator = {
            type = 'group',
            name = "Magic Defense Indicator",
            order = 1,
            args = {
                xOffset = {
                    type = 'range',
                    name = "X Offset",
                    desc = "Horizontal offset for the indicator",
                    min = -100,
                    max = 100,
                    step = 1,
                    order = 1,
                    get = getOption,
                    set = setOption,
                },
                yOffset = {
                    type = 'range',
                    name = "Y Offset",
                    desc = "Vertical offset for the indicator",
                    min = -100,
                    max = 100,
                    step = 1,
                    order = 2,
                    get = getOption,
                    set = setOption,
                },
            },
        },
        physicalReductionIndicator = {
            type = 'group',
            name = "Physics Defense Indicator",
            order = 1,
            args = {
                xOffset = {
                    type = 'range',
                    name = "X Offset",
                    desc = "Horizontal offset for the indicator",
                    min = -100,
                    max = 100,
                    step = 1,
                    order = 1,
                    get = getOption,
                    set = setOption,
                },
                yOffset = {
                    type = 'range',
                    name = "Y Offset",
                    desc = "Vertical offset for the indicator",
                    min = -100,
                    max = 100,
                    step = 1,
                    order = 2,
                    get = getOption,
                    set = setOption,
                },
            },
        },
    },
}


addon.defaultSettings = {
    damageIndicator = { xOffset = -20, yOffset = 25 },
    spellReductionIndicator = { xOffset = 5, yOffset = 25 },
    physicalReductionIndicator = { xOffset = 20, yOffset = 25 },
    onAllies = true,
    showDebug = true,
}
