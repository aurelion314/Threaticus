local addonName, addon = ...
local settings = {}  -- gets set in Initialize

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


function addon:CalculateTotalDamageModifier(relevantBuffs)
    local totalMultiplier = 1.0
    local totalAddition = 0.0

    for _, spellId in ipairs(relevantBuffs) do
        local buffData = addon.defaultSpells[spellId]

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
        local buffData = addon.defaultSpells[spellId]

        if buffData.physicalReduction then
            totalPhysicalMultiplier = totalPhysicalMultiplier * (1 - buffData.physicalReduction)
        end
        if buffData.magicalReduction then
            totalMagicalMultiplier = totalMagicalMultiplier * (1 - buffData.magicalReduction)
        end
        if buffData.reductionModifer then
            totalPhysicalMultiplier = totalPhysicalMultiplier * (1 - buffData.reductionModifer)
            totalMagicalMultiplier = totalMagicalMultiplier * (1 - buffData.reductionModifer)
        end
    end

    return totalPhysicalMultiplier, totalMagicalMultiplier
end

function addon:ScanUnitBuffs(unitID)
    local relevantBuffs = {}
    local i = 1
    while UnitBuff(unitID, i) do
        local name, _, count, _, _, _, _, _, _, spellId = UnitBuff(unitID, i)
        if addon.defaultSpells[spellId] then
            if count == 0 then
                count = 1
            end
            -- add count of them 
            for _ = 1, count do
                table.insert(relevantBuffs, spellId)
            end
        end

        -- Testing
        if name then
            if not ThreaticusDB.unknownSpells[spellId] and not addon.knownSpells[spellId] and not addon.defaultSpells[spellId] then
                -- Add to spell list for review. This will be used to populate the defaultSpells table
                local spellDescription = GetSpellDescription(spellId)
                -- If spell description is blank, call GetSpellTooltip
                if spellDescription == "" then
                    spellDescription = addon:GetSpellTooltip(spellId)
                end
                ThreaticusDB.unknownSpells[spellId] = { name = name, description = spellDescription }
                addon:Debug("New buff found: " .. name .. " (ID: " .. spellId .. ")")
            elseif ThreaticusDB.unknownSpells[spellId] and (addon.knownSpells[spellId] or addon.defaultSpells[spellId]) then
                -- It is already in known. It shouldn't be in spell list. 
                ThreaticusDB.unknownSpells[spellId] = nil
            end 
        end
        i = i + 1
    end

    local totalDamageModifier = self:CalculateTotalDamageModifier(relevantBuffs)
    -- Get name of unit
    local name = UnitName(unitID)
    addon:Debug("Total damage modifier: " .. totalDamageModifier .. " for " .. name)
    local totalPhysicalModifier, totalMagicalModifier = self:CalculateDefensiveModifiers(relevantBuffs)
    addon:Debug("Total physical defensive modifier: " .. totalPhysicalModifier)
    addon:Debug("Total magical defensive modifier: " .. totalMagicalModifier)

    self:DrawOnPlate(unitID, totalDamageModifier, totalPhysicalModifier, totalMagicalModifier)
end

function addon:DrawOnPlate(nameplateID, damageModifier, physicalDefensiveModifier, magicalDefensiveModifier)    
    local frame = C_NamePlate.GetNamePlateForUnit(nameplateID)
    if not frame then return end

    -- Damage Indicator
    local baseSize = 15
    local sizeMultiplier = damageModifier
    local indicatorSize = baseSize + sizeMultiplier
    local color = self:getThreatColor(damageModifier)

    self:UpdateIndicator(frame, "ThreaticusDamageIndicator", indicatorSize, color, "CENTER", "CENTER", settings.damageIndicator.xOffset, settings.damageIndicator.yOffset, "BlipNormal")

    -- Physical Defensive Indicator
    local physicalDefensiveIndicatorSize = addon:CalculateDefensiveIndicatorSize(physicalDefensiveModifier)
    local physicalDefensiveColor = self:getDefensiveColor(physicalDefensiveModifier)
    self:UpdateIndicator(frame, "ThreaticusPhysicalDefensiveIndicator", physicalDefensiveIndicatorSize, physicalDefensiveColor, "CENTER", "CENTER", settings.physicalReductionIndicator.xOffset, settings.physicalReductionIndicator.yOffset, "BlipCombat")

    -- Magical Defensive Indicator
    local magicalDefensiveIndicatorSize = addon:CalculateDefensiveIndicatorSize(magicalDefensiveModifier)
    local magicalDefensiveColor = self:getDefensiveColor(magicalDefensiveModifier)
    self:UpdateIndicator(frame, "ThreaticusMagicalDefensiveIndicator", magicalDefensiveIndicatorSize, magicalDefensiveColor, "CENTER", "CENTER", settings.spellReductionIndicator.xOffset, settings.spellReductionIndicator.yOffset, "BlipCombatHealer")
end

function addon:UpdateIndicator(frame, indicatorKey, size, color, point1, point2, offsetX, offsetY, textureName)
    if not frame[indicatorKey] then
        frame[indicatorKey] = CreateFrame("Frame", nil, frame)
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

function addon:CalculateDefensiveIndicatorSize(defensiveModifier)
    -- Base size for the indicator
    local baseSize = 10
    -- It should get bigger as it approaches 0, maxing out at 3.0. defensiveModifier is between 0 and 1. 0 being that they are
    local sizeMultiplier = ((1 - defensiveModifier)) * 2 * baseSize
    local indicatorSize = baseSize + sizeMultiplier
    return indicatorSize
end


function addon:getDefensiveColor(defensiveModifier)
    -- Transition from light blue (1.0) to dark purple/grey (0)
    local r, g, b

    -- Red component increases as defensiveModifier decreases
    r = (1 - defensiveModifier) * 0.6 -- Cap red at 0.6 for dark purple/grey

    -- Green component decreases to 0 for both blue and purple/grey
    g = defensiveModifier * 0.6 -- Green decreases as defense increases

    -- Blue component starts high for light blue, decreases but remains for purple/grey
    b = 0.8 - (1 - defensiveModifier) * 0.2 -- Keeping blue present for purple/grey

    return {r, g, b, 1}
end


function addon:getThreatColor(damageModifier)
    -- Calculate color based on damageModifier
    local damageModifier = damageModifier + (damageModifier - 1) * 3
    -- Transition from green (1.0) to red (3.0)
    local r, g, b = 1, 1, 0
    if damageModifier <= 2 then
        -- Transition from green to yellow
        r = (damageModifier - 1) / 1
        g = 1
    else
        -- Transition from yellow to red
        r = 1
        g = 1 - ((damageModifier - 2) / 1)
    end
    b = 0
    return {r, g, b, 1}
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

function addon:ApplyDefaultSettings()
    -- Set default settings
    ThreaticusDB.settings = ThreaticusDB.settings or {}
    settings = ThreaticusDB.settings

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
    ThreaticusDB.ignoredSpells = ThreaticusDB.ignoredSpells or {}
    ThreaticusDB.modifierSpells = ThreaticusDB.modifierSpells or {}
end

-- Initialization
local function Initialize()
    ThreaticusDB = ThreaticusDB or {}
    addon:ApplyDefaultSettings()
    
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

    -- While testing, do a quick check to ensure spells list doesn't contain anything already in SpellData
    for spellId, spellData in pairs(ThreaticusDB.unknownSpells) do
        if addon.defaultSpells[spellId] or addon.knownSpells[spellId] then
            ThreaticusDB.unknownSpells[spellId] = nil
        end
    end
 
    -- Initialization logic here (e.g., setting up saved variables, default settings)
    addon.frame:RegisterEvent('NAME_PLATE_UNIT_ADDED')
    addon.frame:RegisterEvent('NAME_PLATE_UNIT_REMOVED')
    addon.frame:RegisterEvent('UNIT_AURA')
end

-- Setting up the event script
addon.frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and (...) == addonName then
        Initialize()
    elseif event == "PLAYER_LOGIN" then
        -- Additional login logic if needed
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
