local _, addon = ...

-- Generic get and set functions
local function getOption(info)
    local setting = ThreaticusDB.settings
    for i = 1, #info - 1 do -- Start from 1 as the root name is not included
        setting = setting[info[i]]
    end
    return setting[info[#info]]
end

local function setOption(info, value)
    local setting = ThreaticusDB.settings
    for i = 1, #info - 1 do -- Start from 1 as the root name is not included
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
        general = {
            type='group',
            name = "General",
            order = 1,
            args = {
                onAllies = {
                    type = 'toggle',
                    name = "Show on Allies",
                    desc = "Show damage indicators on allies",
                    order = 1,
                    get = function()
                        return getOption({"onAllies"})
                    end,
                    set = function(_, value)
                        setOption({"onAllies"}, value)
                    end
                },
                showDebug = {
                    type = 'toggle',
                    name = "Show Debug",
                    desc = "Show debug messages in chat",
                    order = 2,
                    get = function()
                        return getOption({"showDebug"})
                    end,
                    set = function(_, value)
                        setOption({"showDebug"}, value)
                    end
                }
            }
        },
        indicators = {
            type = 'group',
            name = "Indicators",
            order = 2,
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
                            get = function()
                                return getOption({"damageIndicator", "xOffset"})
                            end,
                            set = function(_, value)
                                setOption({"damageIndicator", "xOffset"}, value)
                            end
                        },
                        yOffset = {
                            type = 'range',
                            name = "Y Offset",
                            desc = "Vertical offset for the damage indicator",
                            min = -100,
                            max = 100,
                            step = 1,
                            order = 2,
                            get = function()
                                return getOption({"damageIndicator", "yOffset"})
                            end,
                            set = function(_, value)
                                setOption({"damageIndicator", "yOffset"}, value)
                            end
                        }
                    }
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
                            get = function()
                                return getOption({"spellReductionIndicator", "xOffset"})
                            end,
                            set = function(_, value)
                                setOption({"spellReductionIndicator", "xOffset"}, value)
                            end
                        },
                        yOffset = {
                            type = 'range',
                            name = "Y Offset",
                            desc = "Vertical offset for the indicator",
                            min = -100,
                            max = 100,
                            step = 1,
                            order = 2,
                            get = function()
                                return getOption({"spellReductionIndicator", "yOffset"})
                            end,
                            set = function(_, value)
                                setOption({"spellReductionIndicator", "yOffset"}, value)
                            end
                        }
                    }
                },
                physicalReductionIndicator = {
                    type = 'group',
                    name = "Physical Defense Indicator",
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
                            get = function()
                                return getOption({"physicalReductionIndicator", "xOffset"})
                            end,
                            set = function(_, value)
                                setOption({"physicalReductionIndicator", "xOffset"}, value)
                            end
                        },
                        yOffset = {
                            type = 'range',
                            name = "Y Offset",
                            desc = "Vertical offset for the indicator",
                            min = -100,
                            max = 100,
                            step = 1,
                            order = 2,
                            get = function()
                                return getOption({"physicalReductionIndicator", "yOffset"})
                            end,
                            set = function(_, value)
                                setOption({"physicalReductionIndicator", "yOffset"}, value)
                            end
                        }
                    }
                }
            }
        },
        spellManagement = {
            type = 'group',
            name = "Spell Management",
            order = 3,
            args = {
                unknownSpellsSection = {
                    type = 'group',
                    name = "Unknown Spells",
                    -- inline = true,
                    order = 1,
                    args = {
                        refresh = {
                            type = 'execute',
                            name = "Refresh",
                            func = function()
                                addon:generateSpellManagementOptions()
                            end,
                            order = 1,
                            width = 'half',
                        },
                        clear = {
                            type = 'execute',
                            name = "Clear",
                            func = function()
                                addon:clearTable(ThreaticusDB.unknownSpells)
                                addon:generateSpellManagementOptions()
                            end,
                            order = 2,
                            width = 'half',
                        },
                        -- Dynamic content based on `unknownSpells` will be added here
                    }
                },
                modifierSpellsSection = {
                    type = 'group',
                    name = "Tracked Spells",
                    order = 2,
                    args = {
                        -- Dynamic content based on `modifierSpells` will be added here
                    }
                }, 
                ignoredSpells = {
                    type = 'group',
                    name = "Ignored Spells",
                    order = 3,
                    args = {
                        clear = {
                            type = 'execute',
                            name = "Refresh",
                            func = function()
                                addon:generateSpellManagementOptions()
                            end,
                            order = 1,
                            width = 'half',
                        },
                        -- Dynamic content based on `ignoredSpells` will be added here
                    }
                }
            }
        }
    }
}

function addon:generateSpellManagementOptions()
    local unknownSpellsSection = addon.options.args.spellManagement.args.unknownSpellsSection.args
    local modifierSpellsSection = addon.options.args.spellManagement.args.modifierSpellsSection.args

    -- Clear the existing options except for clear and refresh buttons
    for k in pairs(unknownSpellsSection) do 
        if k ~= "refresh" and k ~= "clear" then
            unknownSpellsSection[k] = nil
        end
    end

    -- Add options for unknown spells
    for spellId, spellData in pairs(ThreaticusDB.unknownSpells or {}) do
        local spellKey = tostring(spellId)
        unknownSpellsSection[spellKey] = {
            type = 'group',
            name = spellData.name,
            inline = true,
            args = {
                spellId = {
                    type = 'description',
                    name = "Spell ID: " .. spellId,
                    fontSize = 'medium',
                    order = 1,
                },
                spellDescription = {
                    type = 'description',
                    name = "Description: " .. spellData.description,
                    fontSize = 'medium',
                    order = 2,
                },
                moveToIgnore = {
                    type = 'execute',
                    name = "Ignore",
                    func = function()
                        -- Logic to move this spell to `ignoredSpells`
                        ThreaticusDB.ignoredSpells[spellId] = spellData
                        ThreaticusDB.unknownSpells[spellId] = nil
                        -- Remove the modifiers UI elements
                        unknownSpellsSection[spellKey] = nil
                    end,
                    order = 3,
                    width = 'half',
                },
                moveToTracked = {
                    type = 'execute',
                    name = "Track",
                    func = function()
                        -- Add additional UI elements to specify modifiers
                        unknownSpellsSection[spellKey].args.modifiersGroup = {
                            type = 'group',
                            name = "Modifiers",
                            inline = true,
                            args = {
                                damageAddition = {
                                    type = 'input',
                                    name = "Damage Addition",
                                    get = function() return spellData.damageAddition and tostring(spellData.damageAddition) or "" end,
                                    set = function(_, val) spellData.damageAddition = tonumber(val) end,
                                    pattern = "%d*%.?%d+", -- pattern to allow decimal numbers
                                    usage = "Enter a numeric value (e.g., 1.2)",
                                    order = 1,
                                },
                                damageMultiplier = {
                                    type = 'input',
                                    name = "Damage Multiplier",
                                    get = function() return spellData.damageMultiplier and tostring(spellData.damageMultiplier) or "" end,
                                    set = function(_, val) spellData.damageMultiplier = tonumber(val) end,
                                    order = 2,
                                },
                                reductionModifier = {
                                    type = 'input',
                                    name = "Reduction Modifier",
                                    get = function() return spellData.reductionModifier and tostring(spellData.reductionModifier) or "" end,
                                    set = function(_, val) spellData.reductionModifier = tonumber(val) end,
                                    order = 3,
                                },
                                magicReductionModifier = {
                                    type = 'input',
                                    name = "Magic Reduction Modifier",
                                    get = function() return spellData.magicReductionModifier and tostring(spellData.magicReductionModifier) or "" end,
                                    set = function(_, val) spellData.magicReductionModifier = tonumber(val) end,
                                    order = 4,
                                },
                                physicalReductionModifier = {
                                    type = 'input',
                                    name = "Physical Reduction Modifier",
                                    get = function() return spellData.physicalReductionModifier and tostring(spellData.physicalReductionModifier) or "" end,
                                    set = function(_, val) spellData.physicalReductionModifier = tonumber(val) end,
                                    order = 5,
                                },
                                save = {
                                    type = 'execute',
                                    name = "Save",
                                    func = function()
                                        -- Logic to move this spell to `modifierSpells`
                                        ThreaticusDB.trackedSpells[spellId] = spellData
                                        ThreaticusDB.unknownSpells[spellId] = nil
                                        -- Remove the modifiers UI elements
                                        unknownSpellsSection[spellKey] = nil
                                    end,
                                    order = 6,
                                    width = 'half',
                                },
                            }
                        }
                    end,
                    order = 4,
                    width = 'half',
                },
            },
        }
    end

    -- Clear the existing options in manage spells
    for k in pairs(modifierSpellsSection) do modifierSpellsSection[k] = nil end
    -- Add options for managed spells
    addon.options.args.spellManagement.args.modifierSpellsSection.args = {
        spellList = {
            type = 'select',
            name = "Select a Spell",
            values = function()
                local spells = {}
                for spellId, spellData in pairs(ThreaticusDB.trackedSpells) do
                    spells[spellId] = spellData.name
                end
        
                -- Sort spells by name
                local sortedSpells = {}
                for spellId, spellName in pairs(spells) do
                    table.insert(sortedSpells, {id = spellId, name = spellName})
                end
                table.sort(sortedSpells, function(a, b) return a.name < b.name end)
        
                local sortedSpellNames = {}
                for _, spell in ipairs(sortedSpells) do
                    sortedSpellNames[spell.id] = spell.name
                end
        
                return sortedSpellNames
            end,
            get = function() return addon.selectedSpellId end,
            set = function(_, spellId) addon.selectedSpellId = spellId end,
            order = 1,
        },
        spellModifiers = {
            type = 'group',
            name = function() return "Modifiers for: " .. (ThreaticusDB.trackedSpells[addon.selectedSpellId] and ThreaticusDB.trackedSpells[addon.selectedSpellId].name or "") end,
            inline = true,
            hidden = function() return not addon.selectedSpellId end,
            order = 2,
            args = {
                damageAddition = {
                    type = 'input',
                    name = "Damage Addition",
                    order = 1,
                    get = function() return tostring(ThreaticusDB.trackedSpells[addon.selectedSpellId] and ThreaticusDB.trackedSpells[addon.selectedSpellId].damageAddition or "") end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].damageAddition = tonumber(value) end,
                },
                damageMultiplier = {
                    type = 'input',
                    name = "Damage Multiplier",
                    order = 2,
                    get = function() return tostring(ThreaticusDB.trackedSpells[addon.selectedSpellId] and ThreaticusDB.trackedSpells[addon.selectedSpellId].damageMultiplier or "") end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].damageMultiplier = tonumber(value) end,
                },
                reductionModifier = {
                    type = 'input',
                    name = "Reduction Modifier",
                    order = 3,
                    get = function() return tostring(ThreaticusDB.trackedSpells[addon.selectedSpellId] and ThreaticusDB.trackedSpells[addon.selectedSpellId].reductionModifier or "") end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].reductionModifier = tonumber(value) end,
                },
                magicReductionModifier = {
                    type = 'input',
                    name = "Magic Reduction Modifier",
                    order = 4,
                    get = function() return tostring(ThreaticusDB.trackedSpells[addon.selectedSpellId] and ThreaticusDB.trackedSpells[addon.selectedSpellId].magicReductionModifier or "") end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].magicReductionModifier = tonumber(value) end,
                },
                physicalReductionModifier = {
                    type = 'input',
                    name = "Physical Reduction Modifier",
                    order = 5,
                    get = function() return tostring(ThreaticusDB.trackedSpells[addon.selectedSpellId] and ThreaticusDB.trackedSpells[addon.selectedSpellId].physicalReductionModifier or "") end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].physicalReductionModifier = tonumber(value) end,
                },
            }
        }
    }

    
    -- add options for Ignored Spells
    local ignoredSpellsSection = addon.options.args.spellManagement.args.ignoredSpells.args
    -- Clear the existing options in ignored spells
    for k in pairs(ignoredSpellsSection) do
        if k ~= "refresh" and k ~= "clear" then
            ignoredSpellsSection[k] = nil
        end
    end

    -- Dynamically add spells to the ignored list
    ignoredSpellsSection["ignoreList"] = {
        type="group",
        name="Select to Remove",
        order = 2,
        inline = true,
        args = {}
    }
    local sortedSpells = addon:sortSpellList(ThreaticusDB.ignoredSpells)
    for spellId, spellData in pairs(sortedSpells) do
        local spellKey = "spell_" .. spellId
        ignoredSpellsSection.ignoreList.args[spellKey] = {
            type = 'execute',
            name = spellData.name .. " (ID: " .. spellId .. ")",
            func = function() 
                ThreaticusDB.ignoredSpells[spellId] = nil
                ignoredSpellsSection.ignoreList.args[spellKey] = nil
                addon:generateSpellManagementOptions()
                end,
            }
    end
end

function addon:sortSpellList(list) 
    table.sort(list, function(a, b) return a.name < b.name end)
    return list
end


addon.defaultSettings = {
    damageIndicator = {
        xOffset = -20,
        yOffset = 25
    },
    spellReductionIndicator = {
        xOffset = 5,
        yOffset = 25
    },
    physicalReductionIndicator = {
        xOffset = 20,
        yOffset = 25
    },
    onAllies = true,
    showDebug = true
}

function addon:clearTable(table)
    for k in pairs(table) do
        table[k] = nil
    end
end

function addon:ApplyDefaultSettings()
    -- Set default settings
    ThreaticusDB.settings = ThreaticusDB.settings or {}
    local settings = ThreaticusDB.settings

    for key, value in pairs(addon.defaultSettings) do
        if settings[key] == nil then
            settings[key] = value
        elseif type(value) == "table" then
            for subKey, subValue in pairs(value) do
                if settings[key][subKey] == nil then
                    settings[key][subKey] = subValue
                end
            end
        end
    end
    ThreaticusDB.unknownSpells = ThreaticusDB.unknownSpells or {}
    ThreaticusDB.ignoredSpells = ThreaticusDB.ignoredSpells or addon.defaultIgnored
    ThreaticusDB.trackedSpells = ThreaticusDB.trackedSpells or addon.defaultTracked

       -- In case defaults change, lets check defaultTracked and defaultIgnored and add them if they are not anywhere.
    for spellId, spellData in pairs(addon.defaultTracked) do
        if not ThreaticusDB.trackedSpells[spellId] and not ThreaticusDB.ignoredSpells[spellId] then
            ThreaticusDB.trackedSpells[spellId] = spellData
        end
    end
    for spellId, spellData in pairs(addon.defaultIgnored) do
        if not ThreaticusDB.trackedSpells[spellId] and not ThreaticusDB.ignoredSpells[spellId] then
            ThreaticusDB.ignoredSpells[spellId] = spellData
        end
    end
end

