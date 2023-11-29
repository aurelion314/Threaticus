local _, addon = ...
local LibPlayerSpells = LibStub("LibPlayerSpells-1.0")
local activeClassFilters = {}
local missingModifierFilter = false

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

addon.classFilters = {
    DRUID = { type = 'toggle', name = "Druid", order = 1, width = "half",     
        get = function() return activeClassFilters["DRUID"] end,
        set = function(_, value) activeClassFilters["DRUID"] = value end 
    },
    MAGE = { type = 'toggle', name = "Mage", order = 2, width = "half" ,
        get = function() return activeClassFilters["MAGE"] end,
        set = function(_, value) activeClassFilters["MAGE"] = value end 
    },
    PALADIN = { type = 'toggle', name = "Paladin", order = 3, width = "half",
        get = function() return activeClassFilters["PALADIN"] end,
        set = function(_, value) activeClassFilters["PALADIN"] = value end 
    },
    PRIEST = { type = 'toggle', name = "Priest", order = 4, width = "half",
        get = function() return activeClassFilters["PRIEST"] end,
        set = function(_, value) activeClassFilters["PRIEST"] = value end 
    },
    ROGUE = { type = 'toggle', name = "Rogue", order = 5, width = "half",
        get = function() return activeClassFilters["ROGUE"] end,
        set = function(_, value) activeClassFilters["ROGUE"] = value end 
    },
    SHAMAN = { type = 'toggle', name = "Shaman", order = 6, width = "half",
        get = function() return activeClassFilters["SHAMAN"] end,
        set = function(_, value) activeClassFilters["SHAMAN"] = value end 
    },
    WARLOCK = { type = 'toggle', name = "Warlock", order = 7, width = "half",
        get = function() return activeClassFilters["WARLOCK"] end,
        set = function(_, value) activeClassFilters["WARLOCK"] = value end 
    },
    WARRIOR = { type = 'toggle', name = "Warrior", order = 8, width = "half",
        get = function() return activeClassFilters["WARRIOR"] end,
        set = function(_, value) activeClassFilters["WARRIOR"] = value end 
    },
    DEATHKNIGHT = { type = 'toggle', name = "Death Knight", order = 9, width = "half",
        get = function() return activeClassFilters["DEATHKNIGHT"] end,
        set = function(_, value) activeClassFilters["DEATHKNIGHT"] = value end 
    },
    HUNTER = { type = 'toggle', name = "Hunter", order = 10, width = "half",
        get = function() return activeClassFilters["HUNTER"] end,
        set = function(_, value) activeClassFilters["HUNTER"] = value end 
    },
    MONK = { type = 'toggle', name = "Monk", order = 11, width = "half",
        get = function() return activeClassFilters["MONK"] end,
        set = function(_, value) activeClassFilters["MONK"] = value end 
    },
    DEMONHUNTER = { type = 'toggle', name = "Demon Hunter", order = 12, width = "half",
        get = function() return activeClassFilters["DEMONHUNTER"] end,
        set = function(_, value) activeClassFilters["DEMONHUNTER"] = value end 
    },
    EVOKER = { type = 'toggle', name = "Evoker", order = 13, width = "half",
        get = function() return activeClassFilters["EVOKER"] end,
        set = function(_, value) activeClassFilters["EVOKER"] = value end 
    },
    missingModifier = { type = 'toggle', name = "Missing Modifier", order = 13,
        get = function() return missingModifierFilter end,
        set = function(_, value) missingModifierFilter = value end 
    },
}

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
                    name = "Show on Friendly",
                    desc = "Show damage indicators on non hostile players",
                    order = 1,
                    get = function()
                        return getOption({"onAllies"})
                    end,
                    set = function(_, value)
                        setOption({"onAllies"}, value)
                        addon:clearAllPlates()
                        addon:refreshView()
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
                testing = {
                    type = 'toggle',
                    name = "Test",
                    desc = "Show the defensive indicators at full alpha",
                    order = 0,
                    get = function()
                        return ThreaticusDB.settings.testing
                    end,
                    set = function(_, value)
                        ThreaticusDB.settings.testing = value
                        addon:refreshView()
                    end
                },
                damageIndicator = {
                    type = 'group',
                    name = "Damage Indicator",
                    inline = true,
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
                        },
                        size = {
                            type = 'range',
                            name = "Size",
                            desc = "Size of the damage indicator",
                            min = 5,
                            max = 50,
                            step = 1,
                            order = 3,
                            get = function()
                                return getOption({"damageIndicator", "size"})
                            end,
                            set = function(_, value)
                                setOption({"damageIndicator", "size"}, value)
                            end
                        },
                        maxValue = {
                            type = 'range',
                            name = "Max Value",
                            desc = "Value of maximum color change on the indicator",
                            min = 0,
                            max = 3,
                            step = 0.1,
                            order = 4,
                            get = function()
                                return getOption({"damageIndicator", "maxValue"})
                            end,
                            set = function(_, value)
                                setOption({"damageIndicator", "maxValue"}, value)
                            end
                        }
                    }
                },
                spellReductionIndicator = {
                    type = 'group',
                    name = "Magic Defense Indicator",
                    inline = true,
                    order = 1,
                    args = {
                        enabled = {
                            type = 'toggle',
                            name = "Enabled",
                            desc = "Enable the magical defense indicator",
                            order = 0,
                            width = 'full',
                            get = function()
                                return getOption({"spellReductionIndicator", "enabled"})
                            end,
                            set = function(_, value)
                                setOption({"spellReductionIndicator", "enabled"}, value)
                            end
                        },
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
                        },
                        size = {
                            type = 'range',
                            name = "Size",
                            desc = "Size of the defensive indicators",
                            min = 5,
                            max = 50,
                            step = 1,
                            order = 3,
                            get = function()
                                return getOption({"spellReductionIndicator", "size"})
                            end,
                            set = function(_, value)
                                setOption({"spellReductionIndicator", "size"}, value)
                            end
                        },
                        minValue = {
                            type = 'range',
                            name = "Min Value",
                            desc = "Value of maximum color change on the indicator",
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 4,
                            get = function()
                                return getOption({"spellReductionIndicator", "minValue"})
                            end,
                            set = function(_, value)
                                setOption({"spellReductionIndicator", "minValue"}, value)
                            end
                        }
                    }
                },
                physicalReductionIndicator = {
                    type = 'group',
                    name = "Physical Defense Indicator",
                    inline = true,
                    order = 1,
                    args = {
                        enabled = {
                            type = 'toggle',
                            name = "Enabled",
                            desc = "Enable the physical defense indicator",
                            order = 0,
                            width = 'full',
                            get = function()
                                return getOption({"physicalReductionIndicator", "enabled"})
                            end,
                            set = function(_, value)
                                setOption({"physicalReductionIndicator", "enabled"}, value)
                            end
                        },
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
                        },
                        minValue = {
                            type = 'range',
                            name = "Min Value",
                            desc = "Value of maximum color change on the indicator",
                            min = 0,
                            max = 1,
                            step = 0.1,
                            order = 3,
                            get = function()
                                return getOption({"physicalReductionIndicator", "minValue"})
                            end,
                            set = function(_, value)
                                setOption({"physicalReductionIndicator", "minValue"}, value)
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
                        description = {
                            type = 'description',
                            name = "Unknown spells have been seen in game but are not tracked or ignored.\n\nWarning: This list can grow very large and freeze the game when displayed. Use Clear button to reset the list",
                            fontSize = 'medium',
                            order = 0,
                        }, 
                        refresh = {
                            type = 'execute',
                            name = "Refresh",
                            func = function()
                                addon:generateUnknownSpellList()
                            end,
                            order = 1,
                            width = 'half',
                        },
                        clear = {
                            type = 'execute',
                            name = "Clear",
                            func = function()
                                addon:clearTable(ThreaticusDB.unknownSpells)
                                addon:generateUnknownSpellList()
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
                },
                addSpell = {
                    type = 'group',
                    name = "Add Spell",
                    order = 4,
                    args = {
                        spellId = {
                            type = 'input',
                            name = "Spell ID",
                            order = 1,
                            width = 'full',
                            get = function() return addon.newSpellId or "" end,
                            set = function(_, value) 
                                addon.newSpellId = value 
                                local spellId = tonumber(addon.newSpellId)
                                if spellId then
                                    local spellName, _, spellIcon = GetSpellInfo(spellId)
                                    if spellName then
                                        local newSpellDescription = addon:GetSpellDescription(spellId)
                                        addon.newSpell = {name = spellName, description = newSpellDescription, id = spellId, icon = spellIcon}
                                    else
                                        addon.newSpell = nil
                                    end
                                end
                            end,
                        },
                        spellDetails = {
                            type = 'description',
                            name = function()
                                -- First ensure we don't already track it.
                                if addon.newSpell and addon.newSpell.name then
                                    return "|T" .. addon.newSpell.icon .. ":0|t " .. addon.newSpell.name .. "\n\n" .. addon.newSpell.description
                                else
                                    return "No spell found."
                                end
                            end,
                            fontSize = "medium",
                            order = 3,
                        },
                        alreadyTrackedMessage = {
                            type = 'description',
                            name = "\nThis spell is already being tracked.",
                            hidden = function()
                                -- Hide this message if no spell is selected or if the spell is not already tracked
                                return not (addon.newSpell and addon.newSpell.id and ThreaticusDB.trackedSpells[addon.newSpell.id])
                            end,
                            order = 4,
                        },
                        addSpell = {
                            type = 'execute',
                            name = "Track Spell",
                            hidden = function()
                                -- Hide the Track Spell button if the spell is already being tracked or if no spell is selected
                                return not (addon.newSpell and addon.newSpell.id) or ThreaticusDB.trackedSpells[addon.newSpell.id]
                            end,
                            func = function()
                                if addon.newSpell and addon.newSpell.id and addon.newSpell.name then
                                    ThreaticusDB.trackedSpells[addon.newSpell.id] = {name = addon.newSpell.name}
                                    addon.newSpellId = nil
                                    addon.newSpell = nil
                                    addon:generateSpellManagementOptions()  -- Refresh the spell management options
                                end
                            end,
                            order = 4,
                            width = 'full',
                        },
                    }
                }
                
            }
        }
    }
}

function addon:generateUnknownSpellList()
    local unknownSpellsSection = addon.options.args.spellManagement.args.unknownSpellsSection.args
    -- Clear the existing options except for clear and refresh buttons
    for k in pairs(unknownSpellsSection) do 
        if k ~= "refresh" and k ~= "clear" and k ~= "description" then
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
                        addon:generateSpellManagementOptions()
                    end,
                    order = 3,
                    width = 'half',
                },
                moveToTracked = {
                    type = 'execute',
                    name = "Track",
                    func = function()
                        -- Logic to move this spell to `modifierSpells`
                        ThreaticusDB.trackedSpells[spellId] = spellData
                        ThreaticusDB.unknownSpells[spellId] = nil
                        -- Remove the modifiers UI elements
                        unknownSpellsSection[spellKey] = nil
                        addon:generateSpellManagementOptions()
                    end,
                    order = 4,
                    width = 'half',
                },
            },
        }
    end
end

function addon:generateSpellManagementOptions()
    local modifierSpellsSection = addon.options.args.spellManagement.args.modifierSpellsSection.args

    -- Clear the existing options in manage spells
    for k in pairs(modifierSpellsSection) do modifierSpellsSection[k] = nil end

    -- Add options for managed spells
    local spellNameFilter = nil;

    local function filterSpells()
        local spells = {}
        local isClassFilterActive = false

        -- Check if any filter is active
        for class, _ in pairs(addon.classFilters) do
            if activeClassFilters[class] then
                isClassFilterActive = true
                break
            end
        end
        -- Add spells that match the filters
        for spellId, spellData in pairs(ThreaticusDB.trackedSpells) do
            local shouldAddSpell = not isClassFilterActive -- Add spell by default if no filter is active

            local flags, providers, modifiedSpells, moreFlags = LibPlayerSpells:GetSpellInfo(spellId)
            if flags then
                if isClassFilterActive then
                    for class, _ in pairs(addon.classFilters) do
                        if activeClassFilters[class] then
                            local classFlag = LibPlayerSpells.constants[class]
                            if classFlag and bit.band(flags, classFlag) ~= 0 then
                                shouldAddSpell = true
                                break
                            end
                        end
                    end
                end
            end
            -- check if it is missing modifies:
            if missingModifierFilter then
                if not spellData.damageAddition and not spellData.damageMultiplier and not spellData.reductionModifier and not spellData.magicReductionModifier and not spellData.physicalReductionModifier then
                    if not isClassFilterActive then
                        shouldAddSpell = true
                    end
                else
                    shouldAddSpell = false
                end
            end
            -- Check spell name
            if spellNameFilter then
                if not string.find(string.lower(spellData.name), string.lower(spellNameFilter)) then
                    shouldAddSpell = false
                end
            end
            -- Add the spell if it matches the filters
            if shouldAddSpell then
                spells[spellId] = spellData.name
            end
        end

        return spells
    end
    
    -- Add a dropdown to select a spell
    addon.options.args.spellManagement.args.modifierSpellsSection.args = {
        classFilterGroup = {
            type = 'group',
            name = "Filters",
            desc = "Class filters are based on static data and may not be up to date.",
            inline = true,
            order = 0,
            args = addon.classFilters
        },
        spellList = {
            type = 'select',
            name = "Select a Spell",
            values = function()
                local spells = filterSpells()
        
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
            set = function(_, spellId) 
                addon.selectedSpellId = spellId 
                addon:generateSpellManagementOptions()
            end,
            order = 1,
        },
        filterSpellName = {
            type = 'input',
            name = "Filter by Name",
            order = 1,
            width = 'full',
            get = function() return spellNameFilter end,
            set = function(_, value) spellNameFilter = value end,
        },
        spellModifiers = {
            type = 'group',
            name = function() return (ThreaticusDB.trackedSpells[addon.selectedSpellId] and ThreaticusDB.trackedSpells[addon.selectedSpellId].name or "") end,
            inline = true,
            hidden = function() return not addon.selectedSpellId end,
            order = 2,
            args = {
                spellInfoHeader = {
                    type = 'header',
                    name = "Spell Information",
                    order = 0,
                },
                spellDescription = {
                    type = 'description',
                    name = function()
                        return "Description: " .. (addon:GetSpellDescription(addon.selectedSpellId) or "N/A")
                    end,
                    fontSize = "medium",
                    order = 2,
                },
                spellTags = {
                    type = 'description',
                    name = function()
                        if addon.selectedSpellId then
                            local flags = LibPlayerSpells:GetSpellInfo(addon.selectedSpellId)
                            local tags = {}
                            if flags then
                                if bit.band(flags, LibPlayerSpells.constants.AURA) ~= 0 then
                                    table.insert(tags, "Aura")
                                end
                                if bit.band(flags, LibPlayerSpells.constants.SURVIVAL) ~= 0 then
                                    table.insert(tags, "Survival")
                                end
                                if bit.band(flags, LibPlayerSpells.constants.BURST) ~= 0 then
                                    table.insert(tags, "Burst")
                                end
                                if bit.band(flags, LibPlayerSpells.constants.IMPORTANT) ~= 0 then
                                    table.insert(tags, "Important")
                                end
                            end
                            return "Tags: " .. (#tags > 0 and table.concat(tags, ", ") or "N/A")
                        end
                        return "Tags: N/A"
                    end,
                    fontSize = "medium",
                    order = 2,
                },
                modifiersHeader = {
                    type = 'header',
                    name = "Modifiers",
                    order = 3,
                },
                damageAddition = {
                    type = 'range',
                    name = "Damage Addition",
                    min = 0,max = 1,step = 0.01,
                    order = 4,
                    get = function() return ThreaticusDB.trackedSpells[addon.selectedSpellId].damageAddition end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].damageAddition = tonumber(value) end,
                },
                damageMultiplier = {
                    type = 'range',
                    name = "Damage Multiplier",
                    min = 1,max = 2,step = 0.01,
                    order = 4,
                    get = function() return ThreaticusDB.trackedSpells[addon.selectedSpellId].damageMultiplier end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].damageMultiplier = tonumber(value) end,
                },
                reductionModifier = {
                    type = 'range',
                    name = "Reduction Modifier",
                    min = 0,max = 1,step = 0.01,
                    order = 5,
                    -- get = function() return tostring(ThreaticusDB.trackedSpells[addon.selectedSpellId] and ThreaticusDB.trackedSpells[addon.selectedSpellId].reductionModifier or "") end,
                    get = function() return ThreaticusDB.trackedSpells[addon.selectedSpellId].reductionModifier end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].reductionModifier = tonumber(value) end,
                },
                magicReductionModifier = {
                    type = 'range',
                    name = "Magic Reduction Modifier",
                    min = 0,max = 1,step = 0.01,
                    order = 5,
                    get = function() return ThreaticusDB.trackedSpells[addon.selectedSpellId].magicReductionModifier end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].magicReductionModifier = tonumber(value) end,
                },
                physicalReductionModifier = {
                    type = 'range',
                    name = "Physical Reduction Modifier",
                    min = 0,max = 1,step = 0.01,
                    order = 6,
                    get = function() return ThreaticusDB.trackedSpells[addon.selectedSpellId].physicalReductionModifier end,
                    set = function(_, value) ThreaticusDB.trackedSpells[addon.selectedSpellId].physicalReductionModifier = tonumber(value) end,
                },
                ignore = {
                    type = 'execute',
                    name = "Move to Ignored",
                    order = 9,
                    func = function()
                        -- Logic to move this spell to `ignoredSpells`
                        ThreaticusDB.ignoredSpells[addon.selectedSpellId] = ThreaticusDB.trackedSpells[addon.selectedSpellId]
                        ThreaticusDB.trackedSpells[addon.selectedSpellId] = nil
                        addon.selectedSpellId = nil
                        addon:generateSpellManagementOptions()
                    end,
                    -- width = 'half',
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
        xOffset = 50,
        yOffset = 10,
        size = 15,
        maxValue = 1.5
    },
    spellReductionIndicator = {
        xOffset = 45,
        yOffset = 15,
        size = 9,
        minValue = 0.6,
        enabled = true,
    },
    physicalReductionIndicator = {
        xOffset = 55,
        yOffset = 15,
        size = 9,
        minValue = 0.6,
        enabled = true,
    },
    onAllies = true,
    showDebug = false
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

