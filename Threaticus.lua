local addonName, addon = ...
local settings = {}  -- gets set in Initialize
local activeSpells = {}

addon.frame = CreateFrame("Frame")
addon.frame:RegisterEvent("ADDON_LOADED")
addon.frame:RegisterEvent("PLAYER_LOGIN")

---------- Helper functions ------
function addon:Debug(...)
    if settings.showDebug then
        print('Threaticus Debug:', ...)
    end
end

-- Create a hidden tooltip frame for scanning
local scannerTooltip = CreateFrame("GameTooltip", "ThreaticusSpellScannerTooltip", nil, "GameTooltipTemplate")
scannerTooltip:SetOwner(WorldFrame, "ANCHOR_NONE")

function addon:GetSpellTooltip(spellId)
    scannerTooltip:ClearLines()
    scannerTooltip:SetSpellByID(spellId)
    local tooltipText = {}
    for i = 1, scannerTooltip:NumLines() do
        local line = _G["ThreaticusSpellScannerTooltipTextLeft" .. i]
        if line and line:GetText() then
            table.insert(tooltipText, line:GetText())
        end
    end
    return table.concat(tooltipText, "\n")
end

function addon:GetSpellDescription(spellId)
    local spellDescription = GetSpellDescription(spellId)
    -- If spell description is blank, call GetSpellTooltip
    if spellDescription == "" then
        spellDescription = addon:GetSpellTooltip(spellId)
    end
    return spellDescription
end


function addon:CalculateTotalDamageModifier(relevantBuffs)
    local totalMultiplier = 1.0
    local totalAddition = 0.0

    for _, spellId in ipairs(relevantBuffs) do
        local buffData = ThreaticusDB.trackedSpells[spellId]

        if buffData.damageMultiplier then
            totalMultiplier = totalMultiplier * buffData.damageMultiplier
        end
        if buffData.damageAddition then
            totalAddition = totalAddition + buffData.damageAddition
        end
    end

    return (1 + totalAddition) * totalMultiplier
end

function addon:CalculateDefensiveModifiers(relevantBuffs)
    local totalPhysicalMultiplier = 1.0
    local totalMagicalMultiplier = 1.0

    for _, spellId in ipairs(relevantBuffs) do
        local buffData = ThreaticusDB.trackedSpells[spellId]

        if buffData.physicalReductionModifier then
            totalPhysicalMultiplier = totalPhysicalMultiplier * (1 - buffData.physicalReductionModifier)
        end
        if buffData.magicReductionModifier then
            totalMagicalMultiplier = totalMagicalMultiplier * (1 - buffData.magicReductionModifier)
        end
        if buffData.reductionModifier then
            totalPhysicalMultiplier = totalPhysicalMultiplier * (1 - buffData.reductionModifier)
            totalMagicalMultiplier = totalMagicalMultiplier * (1 - buffData.reductionModifier)
        end
    end

    return totalPhysicalMultiplier, totalMagicalMultiplier
end



function addon:ScanUnitBuffs(unitID)
    local guid = UnitGUID(unitID)
    local relevantBuffs = {}
    local spellIdsFound = {}  -- Table to track which spell IDs have been found
    local i = 1
    while UnitBuff(unitID, i) do
        local name, _, count, _, _, _, _, _, _, spellId = UnitBuff(unitID, i)
        -- Check if spell is relevant
        if ThreaticusDB.trackedSpells[spellId] then
            if count == 0 then count = 1 end
            -- add count of them 
            for _ = 1, count do
                table.insert(relevantBuffs, spellId)
                spellIdsFound[spellId] = true  -- Mark this spell ID as found
            end
        end

        -- Testing
        if name then
            if not ThreaticusDB.unknownSpells[spellId] and not ThreaticusDB.trackedSpells[spellId] and not ThreaticusDB.ignoredSpells[spellId] then
                -- Add to spell list for review. This will be used to populate the default table
                local spellDescription = addon:GetSpellDescription(spellId)
                ThreaticusDB.unknownSpells[spellId] = { name = name, description = spellDescription }
                addon:Debug("New buff found: " .. name .. " (ID: " .. spellId .. ")")
            elseif ThreaticusDB.unknownSpells[spellId] and (ThreaticusDB.trackedSpells[spellId] or ThreaticusDB.ignoredSpells[spellId]) then
                -- It is already in known. It shouldn't be in spell list. 
                ThreaticusDB.unknownSpells[spellId] = nil
            end 
        end
        i = i + 1
    end

    -- Check for non-buff DPS spells
    local relevantSpells = activeSpells[guid] or {}
    for _, spellCastData in ipairs(relevantSpells) do
        local spellId = spellCastData.spellId
        if ThreaticusDB.trackedSpells[spellId] and not spellIdsFound[spellId] then
            addon:Debug("Found non-buff spell: " .. spellId)
            table.insert(relevantBuffs, spellId)
        end
    end

    local totalDamageModifier = self:CalculateTotalDamageModifier(relevantBuffs)
    -- Get name of unit
    local totalPhysicalModifier, totalMagicalModifier = self:CalculateDefensiveModifiers(relevantBuffs)
    
    local name = UnitName(unitID)
    -- format to 3 decimal places
    addon:Debug(name .. ": " .. string.format("%.3f", totalDamageModifier) .. "x damage, " .. string.format("%.3f", totalPhysicalModifier) .. "x physical, " .. string.format("%.3f", totalMagicalModifier) .. "x magical")

    self:DrawOnPlate(unitID, totalDamageModifier, totalPhysicalModifier, totalMagicalModifier)
end

function addon:DrawOnPlate(nameplateID, damageModifier, physicalDefensiveModifier, magicalDefensiveModifier)    
    local frame = C_NamePlate.GetNamePlateForUnit(nameplateID)
    if not frame then return end

    -- Damage Indicator
    local indicatorSize = addon:CalculateDamageIndicatorSize(damageModifier)
    local color = self:getThreatColor(damageModifier)

    self:UpdateIndicator(frame, "ThreaticusDamageIndicator", indicatorSize, color, "CENTER", "CENTER", settings.damageIndicator.xOffset, settings.damageIndicator.yOffset, "BlipNormal")

    -- Physical Defensive Indicator
    if not settings.physicalReductionIndicator.enabled then
        if frame.ThreaticusPhysicalDefensiveIndicator then
            frame.ThreaticusPhysicalDefensiveIndicator:Hide()
        end
    else
        local physicalDefensiveIndicatorSize = addon:CalculateDefensiveIndicatorSize(physicalDefensiveModifier)
        local physicalDefensiveColor = self:getDefensiveColor(physicalDefensiveModifier, ThreaticusDB.settings.physicalReductionIndicator.minValue)
        self:UpdateIndicator(frame, "ThreaticusPhysicalDefensiveIndicator", physicalDefensiveIndicatorSize, physicalDefensiveColor, "CENTER", "CENTER", settings.physicalReductionIndicator.xOffset, settings.physicalReductionIndicator.yOffset, "Shield")
    end

    -- Magical Defensive Indicator
    if not settings.spellReductionIndicator.enabled then
        if frame.ThreaticusMagicalDefensiveIndicator then
            frame.ThreaticusMagicalDefensiveIndicator:Hide()
        end
    else
        local magicalDefensiveIndicatorSize = addon:CalculateDefensiveIndicatorSize(magicalDefensiveModifier)
        local magicalDefensiveColor = self:getDefensiveColor(magicalDefensiveModifier, ThreaticusDB.settings.spellReductionIndicator.minValue)
        self:UpdateIndicator(frame, "ThreaticusMagicalDefensiveIndicator", magicalDefensiveIndicatorSize, magicalDefensiveColor, "CENTER", "CENTER", settings.spellReductionIndicator.xOffset, settings.spellReductionIndicator.yOffset, "ShieldMagic")
    end
end

function addon:UpdateIndicator(frame, indicatorKey, size, color, point1, point2, offsetX, offsetY, textureName)
    if not frame[indicatorKey] then
        frame[indicatorKey] = CreateFrame("Frame", nil, frame, "ThreaticusIndicatorTemplate")
        local texture = frame[indicatorKey]:CreateTexture(nil, "BACKGROUND")
        texture:SetAllPoints(frame[indicatorKey])
        texture:SetTexture("Interface\\AddOns\\Threaticus\\Textures\\" .. textureName)
        frame[indicatorKey].texture = texture
    end

    frame[indicatorKey]:SetSize(size, size)
    frame[indicatorKey].texture:SetVertexColor(unpack(color))
    frame[indicatorKey]:SetPoint(point1, frame, point2, offsetX, offsetY)
    frame[indicatorKey]:Show()
end

function addon:CalculateDamageIndicatorSize(damageModifier)
    return ThreaticusDB.settings.damageIndicator.size
end

function addon:CalculateDefensiveIndicatorSize(defensiveModifier)
    local baseSize = ThreaticusDB.settings.spellReductionIndicator.size
    return baseSize -- For now lets leave it static
    -- local sizeMultiplier = ((1 - defensiveModifier)) * 2 * baseSize
    -- return baseSize + sizeMultiplier
end


function addon:getDefensiveColor_blue(defensiveModifier, minValue)
    local maxValue = 1
    -- Ensure defensiveModifier is within the bounds of minValue and maxValue
    defensiveModifier = math.max(minValue, math.min(defensiveModifier, maxValue))

    -- Normalize defensiveModifier within the range of minValue and maxValue
    local normalizedModifier = (defensiveModifier - minValue) / (maxValue - minValue)

    -- Transition from light blue (maxValue) to dark purple/grey (minValue)
    local r, g, b

    -- Red component increases as normalizedModifier decreases
    r = (1 - normalizedModifier) * 0.6 -- Cap red at 0.6 for dark purple/grey

    -- Green component decreases to 0 for both blue and purple/grey
    g = normalizedModifier * 0.6 -- Green decreases as defense increases

    -- Blue component starts high for light blue, decreases but remains for purple/grey
    b = 0.8 - (1 - normalizedModifier) * 0.2 -- Keeping blue present for purple/grey

    return {r, g, b, 1}
end

function addon:getDefensiveColor(defensiveModifier, minValue)
    local maxValue = 1
    -- Ensure defensiveModifier is within the bounds of minValue and maxValue
    defensiveModifier = math.max(minValue, math.min(defensiveModifier, maxValue))

    -- Normalize defensiveModifier within the range of minValue and maxValue
    local normalizedModifier = (defensiveModifier - minValue) / (maxValue - minValue)

    -- Transition from soft white (maxValue) to dark grey (minValue)
    -- local greyScaleValue = 0 + (normalizedModifier * 0.8) -- Adjust the range as needed
    local greyScaleValue = 1 -- Adjust the range as needed

    local alpha = 1 - normalizedModifier * 1 -- Adjust the range as needed

    if ThreaticusDB.settings.testing then
        alpha = 1
    end

    return {greyScaleValue, greyScaleValue, greyScaleValue, alpha}
end



function addon:getThreatColor(damageModifier)
    -- Calculate color based on damageModifier. Green at minValue, red at maxValue.
    local maxValue = ThreaticusDB.settings.damageIndicator.maxValue
    local minValue = 1

    -- Correctly handle the case where maxValue is not greater than minValue
    if maxValue <= minValue then
        return {1, 0, 0, 1} -- Return a default color (red) if maxValue is not greater
    end

    if ThreaticusDB.settings.testing then
        damageModifier = ThreaticusDB.settings.damageIndicator.testDamageModifier
    end

    -- Normalize damageModifier within the range of minValue and maxValue
    local normalizedModifier = (damageModifier - minValue) / (maxValue - minValue)

    -- Transition from green to red through yellow
    local r, g, b = 0, 1, 0 -- Start with green
    if normalizedModifier <= 0.5 then
        -- Transition from green to yellow
        r = normalizedModifier * 2 -- Increase red to reach yellow
    else
        -- Transition from yellow to red
        r = 1
        g = 1 - (normalizedModifier - 0.5) * 2 -- Decrease green to reach red
    end

    return {r, g, b, 1}
end

function addon:clearAllPlates()
    local nameplates = C_NamePlate.GetNamePlates()
    for _, nameplate in ipairs(nameplates) do
        if nameplate.ThreaticusDamageIndicator then
            nameplate.ThreaticusDamageIndicator:Hide()
        end
        if nameplate.ThreaticusPhysicalDefensiveIndicator then
            nameplate.ThreaticusPhysicalDefensiveIndicator:Hide()
        end
        if nameplate.ThreaticusMagicalDefensiveIndicator then
            nameplate.ThreaticusMagicalDefensiveIndicator:Hide()
        end
    end
end

function addon:CleanupExpiredSpells()
    local currentTime = GetTime()

    for guid, spells in pairs(activeSpells) do
        local i = 1
        while i <= #spells do
            local spellCastData = spells[i]
            if currentTime > (spellCastData.timestamp + spellCastData.duration) then
                -- Spell expired, remove it
                table.remove(spells, i)
                addon:Debug("Removed expired spell: " .. spellCastData.spellId)
            else
                -- Only increment if we didn't remove a spell (as that shifts the array)
                i = i + 1
            end
        end
    end
end

function addon:StartCleanupTimer()
    self.cleanupTimer = C_Timer.NewTicker(1, function() 
        self:CleanupExpiredSpells()
    end)
end

function addon:COMBAT_LOG_EVENT_UNFILTERED()
    local _, eventType, _, sourceGUID, sourceName, _, _, destGUID, destName, _, _, spellId, spellName = CombatLogGetCurrentEventInfo()

    if eventType == "SPELL_CAST_SUCCESS" then
        -- Check if the spell is one that you're interested in
        if ThreaticusDB.trackedSpells[spellId] then
            -- Store the spell cast along with the source GUID
            activeSpells[sourceGUID] = activeSpells[sourceGUID] or {}
            local duration = ThreaticusDB.trackedSpells[spellId].duration or 0
            table.insert(activeSpells[sourceGUID], {spellId = spellId, timestamp = GetTime(), duration = duration})
            addon:Debug("Added spell: " .. spellId)
        else
            if not ThreaticusDB.unknownSpells[spellId] and not ThreaticusDB.trackedSpells[spellId] and not ThreaticusDB.ignoredSpells[spellId] then
                -- Add to spell list for review. This will be used to populate the default table
                local spellDescription = addon:GetSpellDescription(spellId)
                ThreaticusDB.unknownSpells[spellId] = { name = spellName, description = spellDescription }
                addon:Debug("New buff found: " .. spellName .. " (ID: " .. spellId .. ")")
            elseif ThreaticusDB.unknownSpells[spellId] and (ThreaticusDB.trackedSpells[spellId] or ThreaticusDB.ignoredSpells[spellId]) then
                -- It is already in known. It shouldn't be in spell list. 
                ThreaticusDB.unknownSpells[spellId] = nil
            end 
        end
    end
end

function addon:NAME_PLATE_UNIT_ADDED(unitID)
    addon.alwaysOn = true  -- Test
    if UnitIsPlayer(unitID) and (UnitCanAttack("player", unitID) or settings.onAllies) then
        self:ScanUnitBuffs(unitID)
    end
end

function addon:NAME_PLATE_UNIT_REMOVED(unitID)
    local frame = C_NamePlate.GetNamePlateForUnit(unitID)
    -- ThreaticusMagicalDefensiveIndicator, ThreaticusPhysicalDefensiveIndicator, ThreaticusDamageIndicator
    if frame then
        if frame.ThreaticusDamageIndicator then
            frame.ThreaticusDamageIndicator:Hide()
        end
        if frame.ThreaticusPhysicalDefensiveIndicator then
            frame.ThreaticusPhysicalDefensiveIndicator:Hide()
        end
        if frame.ThreaticusMagicalDefensiveIndicator then
            frame.ThreaticusMagicalDefensiveIndicator:Hide()
        end
    end
end

function addon:UNIT_AURA(unitID)
    -- Logic for when a unit's auras change
    if UnitIsPlayer(unitID) and (UnitCanAttack("player", unitID) or settings.onAllies) then
        self:ScanUnitBuffs(unitID)
    end
end

function addon:refreshView()
    -- get all visible nameplates
    local nameplates = C_NamePlate.GetNamePlates()
    for _, nameplate in ipairs(nameplates) do
        local unitFrame = nameplate.UnitFrame or nameplate.unitFrame -- Adjust based on your UI setup
        if unitFrame and unitFrame.unit then
            local unitID = unitFrame.unit
            if UnitIsPlayer(unitID) and (UnitCanAttack("player", unitID) or settings.onAllies) then
                self:ScanUnitBuffs(unitID)
            end
        end
    end
end

-- Initialization
local function Initialize()
    ThreaticusDB = ThreaticusDB or {}
    addon:ApplyDefaultSettings()
    settings = ThreaticusDB.settings
    addon:generateSpellManagementOptions()
    
    -- Init options
    local config = LibStub("AceConfig-3.0")
    local dialog = LibStub("AceConfigDialog-3.0")
    config:RegisterOptionsTable("ThreaticusOptions", addon.options)
    addon.optionsFrame = dialog:AddToBlizOptions("ThreaticusOptions", "Threaticus")
    -- Slash command
    SLASH_THREATICUS1 = "/threaticus"
    SlashCmdList["THREATICUS"] = function(msg)
        InterfaceOptionsFrame_OpenToCategory(addon.optionsFrame)
        InterfaceOptionsFrame_OpenToCategory(addon.optionsFrame) -- Twice to workaround a Blizzard bug
    end
 
    -- Initialization logic here (e.g., setting up saved variables, default settings)
    addon.frame:RegisterEvent('COMBAT_LOG_EVENT_UNFILTERED')
    addon.frame:RegisterEvent('NAME_PLATE_UNIT_ADDED')
    addon.frame:RegisterEvent('NAME_PLATE_UNIT_REMOVED')
    addon.frame:RegisterEvent('UNIT_AURA')

    addon:StartCleanupTimer()
end

-- Setting up the event script
addon.frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and (...) == addonName then
        Initialize()
    elseif event == "PLAYER_LOGIN" then
        -- Additional login logic if needed
    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        addon:COMBAT_LOG_EVENT_UNFILTERED(...)
    elseif event == "NAME_PLATE_UNIT_ADDED" then
        addon:NAME_PLATE_UNIT_ADDED(...)
    elseif event == "NAME_PLATE_UNIT_REMOVED" then
        addon:NAME_PLATE_UNIT_REMOVED(...)
    elseif event == "UNIT_AURA" then
        if strmatch((...), "nameplate%d+") then
            addon:UNIT_AURA(...)
        end
    end
end)