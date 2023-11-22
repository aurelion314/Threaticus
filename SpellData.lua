local addonName, addon = ...

-- Default list to watch for. These are spells with modifiers that we need to account for.
-- Possible modifiers are: damageAddition, damageMultiplier, reductionModifier, magicReductionModifier, physicalReductionModifier
addon.defaultTracked = {
    [418563] = { 
        name = "WoW Anniverseray", 
    },
    [23456] = {
        name = "Example Spell",
        damageAddition = 0.1,
        damageMultiplier = 1.2,
        reductionModifier = 0.1,
        magicReductionModifier = 0.1,
        physicalReductionModifier = 0.1,
    },
    [6673] = {
        name = "Battle Shout",
        damageMultiplier = 1.05 -- Estimated
    },
    [387336] = {
        name = "Zone of Focus",
        reductionModifier = 0.05 -- Estimated
    },

    [175784] = {
        name = "Well Fed",
        damageMultiplier = 1.05 -- Estimated for food buffs
    },

    [196099] = {
        name = "Grimoire of Sacrifice",
        damageMultiplier = 1.1 -- Estimated
    },

    [11426] = {
        name = "Ice Barrier",
        reductionModifier = 0.05 -- Estimated
    },

    [386196] = {
        name = "Berserker Stance",
        damageMultiplier = 1.1, -- Estimated
        physicalReductionModifier = -0.05 -- Estimated trade-off for increased damage
    },

    [193358] = {
        name = "Grand Melee",
        damageMultiplier = 1.05 -- Estimated
    },

    [17] = {
        name = "Power Word: Shield",
        reductionModifier = 0.1 -- Estimated
    },
    [386208] = {
        name = "Defensive Stance",
        reductionModifier = 0.1 -- Estimated
    },

    [13750] = {
        name = "Adrenaline Rush",
        damageMultiplier = 1.2 -- Estimated
    },

    [465] = {
        name = "Devotion Aura",
        reductionModifier = 0.03
    },

    [257622] = {
        name = "Trick Shots",
        damageMultiplier = 1.05 -- Estimated based on enhanced damage potential
    },

    [257946] = {
        name = "Thrill of the Hunt",
        damageMultiplier = 1.05 -- Estimated
    },

    [24858] = {
        name = "Moonkin Form",
        damageMultiplier = 1.1,
        physicalReductionModifier = 0.125 -- Estimated based on armor increase
    },

    [162264] = {
        name = "Metamorphosis",
        damageMultiplier = 1.2 -- Estimated based on enhanced abilities
    },

    [1126] = {
        name = "Mark of the Wild",
        damageMultiplier = 1.03 -- Versatility increase can affect damage
    },

    [381637] = {
        name = "Atrophic Poison",
    },

    [382154] = {
        name = "Well Fed",
        damageMultiplier = 1.05 -- Estimated for food buffs
    },


    [371353] = {
        name = "Elemental Chaos: Frost",
        damageMultiplier = 1.05 -- Estimated based on versatility increase
    },

    [260286] = {
        name = "Tip of the Spear",
        damageMultiplier = 1.05 -- Estimated based on enhanced damage potential
    },

    [197625] = {
        name = "Moonkin Form",
        damageMultiplier = 1.1, -- Estimated based on damage increase
        physicalReductionModifier = 0.125 -- Estimated based on armor increase
    },


    [193538] = {
        name = "Alacrity",
        damageMultiplier = 1.01 -- Haste increase can affect overall damage
    },

    [175785] = {
        name = "Well Fed",
        damageMultiplier = 1.05 -- Estimated for food buffs
    },

    [382079] = {
        name = "Incarnate's Mark of Frost",
        damageMultiplier = 1.05, -- Assuming a medium amount Critical Strike increase slightly boosts overall damage.
    },

    [396092] = {
        name = "Well Fed",
        damageMultiplier = 1.03, -- Assuming a primary stat increase translates to a moderate damage increase.
    },

    [264663] = {
        name = "Predator's Thirst",
        reductionModifier = 0.1, -- Leech provides self-healing, contributing to effective damage reduction.
    },

    [5487] = {
        name = "Bear Form",
        physicalReductionModifier = 0.3, -- Significant increase in armor suggests a substantial reduction in physical damage.
    },

    [80353] = {
        name = "Time Warp",
        damageMultiplier = 1.3, -- Haste significantly increases overall damage output.
    },


    [374000] = {
        name = "Iced Phial of Corrupting Rage",
        damageMultiplier = 1.03, -- Critical Strike increase moderately boosts damage.
    },
    [395336] = {
        name = "Protector of the Pack",
    },
    [116267] = {
        name = "Incanter's Flow",
        damageMultiplier = 1.02, -- Assuming a moderate variable damage increase.
    },

    [393438] = {
        name = "Draconic Augmentation",
        damageMultiplier = 1.04, -- Slight increase in primary stats leads to a mild damage boost.
    },

    [374002] = {
        name = "Corrupting Rage",
        damageMultiplier = 1.03, -- Similar to Iced Phial of Corrupting Rage.
    },
    [2823] = { 
        name = "Deadly Poison", 
        damageAddition = 0.03, -- Assuming a constant poison damage over time.
    },

    [371172] = {
        name = "Phial of Tepid Versatility",
        damageMultiplier = 1.02, -- Versatility increases both damage output and damage reduction.
        reductionModifier = 0.02,
    },
    [315496] = {
        name = "Slice and Dice",
        damageMultiplier = 1.05, -- Significant increase in attack speed likely leads to a substantial increase in damage output.
    },

    [108211] = {
        name = "Leeching Poison",
    },
    [381664] = {
        name = "Amplifying Poison",
        damageMultiplier = 1.05, -- Considering the potential 35% increased damage from Envenom.
    },

    [391099] = {
        name = "Dark Evangelism",
        damageMultiplier = 1.053, -- Assuming the maximum 5% increase in periodic damage.
    },
    [232698] = {
        name = "Shadowform",
        damageMultiplier = 1.1, -- 10% increase in spell damage.
    },
    [382153] = {
        name = "Well Fed",
        damageMultiplier = 1.03, -- Increase in Haste and Versatility translates to a mild boost in damage.
    },

    [345230] = {
        name = "Gladiator's Insignia",
        damageMultiplier = 1.1, -- Brief increase in primary stat suggests a small boost in damage.
    },
    [386164] = {
        name = "Battle Stance",
        damageMultiplier = 1.03, -- 3% increase in critical strike chance can moderately increase overall damage.
    },

    [385127] = {
        name = "Blessing of Dawn",
        damageMultiplier = 1.2, -- 20% additional increased damage for Holy Power spending ability.
    },

    [226807] = {
        name = "Well Fed",
        damageMultiplier = 1.03, -- Estimated for food buffs
    },
        
    [5217] = {
        name = "Tiger's Fury",
        damageMultiplier = 1.15, -- 15% increase in damage for 10 seconds.
    },
    
    [356661] = {
        name = "Chaotic Imprint - Fire",
        damageMultiplier = 1.1, -- Increases target's damage taken from a school by 10% for 20 sec.
    },
    [183435] = {
        name = "Retribution Aura",
        damageMultiplier = 1.05, -- 5% increased damage under specific conditions.
    },

    [287280] = {
        name = "Glimmer of Light",
        damageAddition = 0.05,
    },
    [260734] = {
        name = "Master of the Elements",
        damageMultiplier = 1.1,
    },
    [382080] = {
        name = "Incarnate's Mark of Fire",
        damageMultiplier = 1.05,
    },

    [390192] = {
        name = "Ragefire",
        damageMultiplier = 1.1,
    },
    [48107] = {
        name = "Heating Up",
        damageMultiplier = 1.05,
    },

    [373183] = {
        name = "Harsh Discipline",
        damageMultiplier = 1.05,
    },
    [202602] = {
        name = "Into the Fray",
        damageAddition = 0.05,
    },
    [401187] = {
        name = "Molten Overflow",
        damageMultiplier = 1.1,
    },

    [406921] = {
        name = "Adaptive Stonescales",
        physicalReductionModifier = 0.05,
    },

    [124974] = {
        name = "Nature's Vigil",
        reductionModifier = 0.05,
    },
    [3408] = {
        name = "Crippling Poison",
        physicalReductionModifier = 0.1,
    },

    [391882] = {
        name = "Apex Predator's Craving",
        damageMultiplier = 1.1,
    },

    [129914] = {
        name = "Power Strikes",
        damageAddition = 0.05,
    },
    [93622] = {
        name = "Gore",
        damageMultiplier = 1.05,
    },

    [383883] = {
        name = "Fury of the Sun King",
        damageMultiplier = 1.15,
    },
    [102543] = {
        name = "Incarnation: Avatar of Ashamane",
        damageMultiplier = 1.2,
    },

    [383018] = {
        name = "Stoneskin",
        physicalReductionModifier = 0.1,
    },

    [258920] = {
        name = "Immolation Aura",
        damageMultiplier = 1.05,
    },
    [383997] = {
        name = "Arcane Tempo",
        damageMultiplier = 1.02,
    },
    [408340] = {
        name = "Shadows of the Predator",
        damageAddition = 0.01,
    },
    
    [10060] = {
        name = "Power Infusion",
        damageAddition = 1.2, -- 20% haste increase could imply damage increase
    },

    [264173] = {
        name = "Demonic Core",
        damageMultiplier = 1.1, -- 100% reduction in cast time might imply a damage increase
    },
    
    [1022] = {
        name = "Blessing of Protection",
        physicalReductionModifier = 1.0, -- Immunity to physical damage
    },
    [642] = {
        name = "Divine Shield",
        reductionModifier = 1.0, -- Immunity to all damage
    },

    [47585] = {
        name = "Dispersion",
        reductionModifier = 0.25, -- 75% damage reduction
    },
    
    [22812] = {
        name = "Barkskin",
        reductionModifier = 0.2, -- 20% damage reduction
    },
}

-- These are all known spells, even if they have no modifiers. 
addon.defaultIgnored = {
    [382093] = { 
        name = "Alchemically Inspired", 
        -- Unclear effect, no modifiers estimated
    },
    [139448] = {
        name = "Clutch of Ji-Kun",
        -- No combat modifiers (Mount)
    },
    [207203] = {
        name = "Frost Shield",
        -- Unclear effect, possibly a reductionModifier but no specific data
    },
    [383492] = {
        name = "Wildfire",
        -- Unclear effect, no modifiers estimated
    },
    [390787] = {
        name = "Weal and Woe",
        -- Unclear effect, no modifiers estimated
    },
    [157644] = {
        name = "Pyrotechnics",
        -- Unclear effect, possibly related to damage but no specifics
    },
    [2584] = {
        name = "Waiting to Resurrect",
        -- No combat modifiers
    },
    [343648] = {
        name = "Solstice",
        -- Unclear effect, no modifiers estimated
    },
    [264571] = {
        name = "Nightfall",
        -- Unclear effect, no modifiers estimated
    },
    [201846] = {
        name = "Stormbringer",
        -- Effect on cooldown reset, not directly a damage modifier
    },
    [386237] = {
        name = "Fade to Nothing",
        -- Unclear effect, no modifiers estimated
    },
    [353646] = {
        name = "Fel Obelisk",
        -- Unclear effect, no modifiers estimated
    },
    [373276] = {
        name = "Idol of Yogg-Saron",
        -- No combat modifiers
    },
    [405225] = {
        name = "Stone Breaker",
        -- Unclear effect, no modifiers estimated
    },
    [281036] = {
        name = "Dire Beast",
        -- Unclear effect, possibly related to summoning but no specific damage modifier
    },
    [375986] = {
        name = "Primordial Wave",
        -- Unclear effect, no modifiers estimated
    },
    [342246] = {
        name = "Alter Time",
        -- No direct combat modifiers
    },
    [1044] = {
        name = "Blessing of Freedom",
        -- No damage or defense modifiers, immunity to movement impairing effects
    },
    [418744] = {
        name = "Dreamsurge Learnings",
        -- No combat modifiers, experience and reputation gains
    },
    [401394] = {
        name = "Unstable Flames",
        -- Unclear effect, no modifiers estimated
    },
    [383637] = {
        name = "Fiery Rush",
        -- Unclear effect, no modifiers estimated
    },
    [381752] = {
        name = "Blessing of the Bronze",
        -- Unclear effect, no modifiers estimated
    },
    [184662] = {
        name = "Shield of Vengeance",
    },
    [371348] = {
        name = "Elemental Chaos: Fire",
        -- Unclear effect, no modifiers estimated
    },
    [385787] = {
        name = "Matted Fur",
        -- Unclear effect, no modifiers estimated
    },
    [389387] = {
        name = "Awakened Faeline",
        -- Unclear effect, no modifiers estimated
    },
    [216528] = {
        name = "Waterspeaker's Blessing",
        -- Unclear effect, no modifiers estimated
    },
    [366155] = {
        name = "Reversion",
        -- Unclear effect, no modifiers estimated
    },
    [305497] = {
        name = "Thorns",
        -- Damage reflection, no clear damage reduction or increase modifiers
    },
    [111400] = {
        name = "Burning Rush",
        -- Unclear effect, no modifiers estimated
    },
    [391688] = {
        name = "Dancing Blades",
        -- Unclear effect, no modifiers estimated
    },
    [347462] = { 
        name = "Unbound Chaos", 
    },

    [44535] = {
        name = "Spirit Heal",
        -- No combat modifiers
    },
    [368158] = {
        name = "Zereth Overseer",
        -- No combat modifiers
    },
    [387066] = {
        name = "Wrath of Consumption",
        -- Unclear effect, no modifiers estimated
    },
    [170347] = {
        name = "Core Hound",
        -- No combat modifiers
    },
    [73325] = {
        name = "Leap of Faith",
        -- No combat modifiers
    },
    [198069] = {
        name = "Power of the Dark Side",
        -- Unclear effect, no modifiers estimated
    },
    [185422] = {
        name = "Shadow Dance",
        -- Unclear effect, no modifiers estimated
    },
    [274009] = {
        name = "Voracious",
        -- Unclear effect, no modifiers estimated
    },
    [355897] = {
        name = "Inner Light",
        -- Unclear effect, no modifiers estimated
    },
    [216338] = {
        name = "Food",
        -- No combat modifiers
    },
    [355898] = {
        name = "Inner Shadow",
        -- Unclear effect, no modifiers estimated
    },
    [426672] = {
        name = "Best Friends with Urctos",
        -- No combat modifiers
    },
    [219788] = {
        name = "Ossuary",
        -- Unclear effect, no modifiers estimated
    },
    [414664] = {
        name = "Mass Invisibility",
        -- No combat modifiers
    },
    [216339] = {
        name = "Drink",
        -- No combat modifiers
    },
    [393969] = {
        name = "Danse Macabre",
        -- Unclear effect, no modifiers estimated
    },
    [403295] = {
        name = "Black Attunement",
        -- No direct combat modifiers, but may affect health
    },
    [54149] = {
        name = "Infusion of Light",
        -- Unclear effect, no modifiers estimated
    },
    [387327] = {
        name = "Shadow's Bite",
        -- Unclear effect, no modifiers estimated
    },
    [393971] = {
        name = "Soothing Darkness",
        -- Unclear effect, no modifiers estimated
    },
    [216468] = {
        name = "Saltwater Potion",
        -- No combat modifiers
    },
    [394738] = {
        name = "Vicious Sabertooth",
        -- No combat modifiers
    },
    [166646] = {
        name = "Windwalking",
        -- No combat modifiers
    },
    [186257] = {
        name = "Aspect of the Cheetah",
        -- No combat modifiers
    },
    [216343] = {
        name = "Well Fed",
        -- No combat modifiers
    },
    [387334] = {
        name = "Infurious Legwraps of Possibility",
        -- Unclear effect, no modifiers estimated
    },
    [390145] = {
        name = "Inner Demon",
        -- Unclear effect, no modifiers estimated
    },
    [389890] = {
        name = "Tactical Retreat",
        -- No direct combat modifiers
    },
    [401516] = {
        name = "Ruby Resonance",
        -- Unclear effect, no modifiers estimated
    },
    [262652] = {
        name = "Forceful Winds",
        -- Unclear effect, no modifiers estimated
    },
    [334320] = {
        name = "Inevitable Demise",
        -- Unclear effect, no modifiers estimated
    },
    [368896] = { 
        name = "Renewed Proto-Drake",
    },
    [259395] = {
        name = "Shu-Zen, the Divine Sentinel",
    },
    [222202] = {
        name = "Prestigious Bronze Courser",
    },
    [403265] = {
        name = "Bronze Attunement",
    },
    [97340] = {
        name = "Guild Champion",
    },
    [391312] = {
        name = "Wrapped Up In Weaving",
    },
    [72286] = {
        name = "Invincible",
    },
    [46739] = {
        name = "Personalized Weather",
    },
    [427407] = {
        name = "Devastating Dreams",
        damageMultiplier = 1.2,
    },
    [368899] = {
        name = "Windborne Velocidrake",
    },
    [101168] = {
        name = "Haunted",
    },
    [2479] = {
        name = "Honorless Target",
    },
    [48265] = {
        name = "Death's Advance",
    },
    [392071] = {
        name = "Spa flowers",
    },
    [409664] = {
        name = "Contract: Loamm Niffen",
    },
    [93821] = {
        name = "Gnomeregan Champion",
    },
    [7353] = {
        name = "Cozy Fire",
    },
    [72968] = {
        name = "Precious's Ribbon",
    },
    [106898] = {
        name = "Stampeding Roar",
    },
    [200652] = {
        name = "Tyr's Deliverance",
    },
    [418644] = {
        name = "Rift Sickness",
    },
    [391215] = {
        name = "Initiative",
    },
    [424851] = {
        name = "Elemental Augury",
    },
    [61781] = {
        name = "Turkey Feathers",
    },
    [405809] = {
        name = "Shaohao's Lesson - Fear",
    },
    [135700] = {
        name = "Clearcasting",
    },
    [145152] = { 
        name = "Bloodtalons", 
        -- No specific damage or defense modifier can be inferred.
    },
    [42777] = {
        name = "Swift Spectral Tiger",
        -- This is a mount and does not affect combat stats.
    },
    [354838] = {
        name = "Echoing Reprimand",
        -- No specific damage or defense modifier can be inferred.
    },
    [32645] = {
        name = "Envenom",
        -- Specific damage increase is unclear.
    },
    [342076] = {
        name = "Streamline",
        -- No specific damage or defense modifier can be inferred.
    },
    [390178] = {
        name = "Plaguebringer",
        -- No specific damage or defense modifier can be inferred.
    },
    [231435] = {
        name = "Highlord's Golden Charger",
        -- This is a mount and does not affect combat stats.
    },

    [393959] = {
        name = "Nature's Grace",
        -- Haste increase does not directly translate to a damage or defense modifier.
    },
    [408375] = {
        name = "Master of Death",
        -- No specific damage or defense modifier can be inferred.
    },
    [393961] = {
        name = "Primordial Arcanic Pulsar",
        -- No specific damage or defense modifier can be inferred.
    },
    [251837] = {
        name = "Flask of Endless Fathoms",
        -- No specific damage or defense modifier can be inferred.
    },
    [388598] = {
        name = "Ride Along",
        -- No specific damage or defense modifier can be inferred.
    },
    [131347] = {
        name = "Glide",
        -- Reduces falling speed, does not affect combat stats.
    },
    [113120] = {
        name = "Feldrake",
        -- This is a mount and does not affect combat stats.
    },
    [194879] = {
        name = "Icy Talons",
        -- No specific damage or defense modifier can be inferred.
    },
    [63956] = {
        name = "Ironbound Proto-Drake",
        -- This is a mount and does not affect combat stats.
    },
    [69369] = {
        name = "Predatory Swiftness",
        -- No specific damage or defense modifier can be inferred.
    },
    [276111] = {
        name = "Divine Steed",
        -- No specific damage or defense modifier can be inferred.
    },
    [394001] = {
        name = "Sculpting Leather Finery",
        -- No specific damage or defense modifier can be inferred.
    },
    [46740] = {
        name = "Personalized Weather",
        -- No specific damage or defense modifier can be inferred.
    },
    [414133] = {
        name = "Overflowing Light",
        -- No specific damage or defense modifier can be inferred.
    },
    [243651] = {
        name = "Shackled Ur'zul",
        -- This is a mount and does not affect combat stats.
    },
    [290754] = {
        name = "Lifebloom",
        -- No specific damage or defense modifier can be inferred.
    },
    [61425] = {
        name = "Traveler's Tundra Mammoth",
        -- This is a mount and does not affect combat stats.
    },
    [410231] = {
        name = "Undulating Sporecloak",
        -- No specific damage or defense modifier can be inferred.
    },
    [383882] = {
        name = "Sun King's Blessing",
        -- No specific damage or defense modifier can be inferred.
    },
    [368893] = {
        name = "Winding Slitherdrake",
        -- This is a mount and does not affect combat stats.
    }, 
    [164273] = { 
        name = "Lone Wolf", 
    },
    [52127] = {
        name = "Water Shield",
    },
    [386159] = {
        name = "High Intensity Thermal Scanner",
    },
    [93095] = {
        name = "Burgy Blackheart's Handsome Hat",
    },
    [371339] = {
        name = "Phial of Elemental Chaos",
    },
    [93816] = {
        name = "Gilneas Champion",
    },
    [388998] = {
        name = "Razor Fragments",
    },
    [24735] = {
        name = "Ghost Costume",
    },
    [381684] = {
        name = "Brimming with Life",
    },
    [385996] = {
        name = "Revealing Dragon's Eye",
    },
    [260249] = {
        name = "Bloodseeker",
    },
    [296863] = {
        name = "Inflatable Mount Shoes",
    },
    [388380] = {
        name = "Dragonrider's Compassion",
    },
    [46738] = {
        name = "Personalized Weather",
    },
    [383395] = {
        name = "Feel the Burn",
    },
    [264656] = {
        name = "Pathfinding",
    },
    [371350] = {
        name = "Elemental Chaos: Air",
    },
    [388672] = {
        name = "Dragonrider's Initiative",
    },
    [48108] = {
        name = "Hot Streak!",
    },
    [222238] = {
        name = "Prestigious Ivory Courser",
    },
    [423906] = {
        name = "Dancing Dream Blossoms",
    },
    [406975] = {
        name = "Divine Arbiter",
    },
    [422785] = {
        name = "Ride Along",
    },
    [382028] = {
        name = "Improved Flametongue Weapon",
    },
    [116841] = {
        name = "Tiger's Lust",
    },
    [395197] = {
        name = "Mana Spring",
    },
    [378770] = {
        name = "Deathblow",
    },
    [427296] = {
        name = "Healing Elixir",
    },
    [418590] = {
        name = "Static Charge",
    },
    [264662] = {
        name = "Endurance Training",
    },
    [1459] = {
        name = "Arcane Intellect",
    },
    [192106] = {
        name = "Lightning Shield",
    },
    [381954] = {
        name = "Spoils of Neltharus",
    },
    [356660] = {
        name = "Chaotic Imprint - Nature",
    },
    [417456] = {
        name = "Accelerating Sandglass",
    },
    [381957] = {
        name = "Spoils of Neltharus",
    },
    [347600] = {
        name = "Infused Ruby Tracking",
    },
    [368901] = {
        name = "Cliffside Wylderdrake",
    },
    [427303] = {
        name = "Spriggan Vision",
    },
    [412088] = {
        name = "Grotto Netherwing Drake",
    },
    [256374] = {
        name = "Entropic Embrace",
    },
    [278310] = {
        name = "Chain Reaction",
    },
    [417492] = {
        name = "Cryopathy",
    },
    [297871] = {
        name = "Anglers' Water Striders",
    },
    [205766] = {
        name = "Bone Chilling",
    },
    [196911] = {
        name = "Shadow Techniques",
    },
    [190446] = {
        name = "Brain Freeze",
    },
    [414976] = {
        name = "Rage of Azzinoth",
    },
    [247776] = {
        name = "Mind Trauma",
    },
    [408770] = {
        name = "Flash of Inspiration",
    },
    [358733] = {
        name = "Glide",
    },
    [205473] = {
        name = "Icicles",
    },
    [425153] = {
        name = "Firestarter",
    },
    [425949] = {
        name = "Vantus Rune: Fyrakk the Blazing",
    },
    [381956] = {
        name = "Spoils of Neltharus",
    },
    [236502] = {
        name = "Tidebringer",
    },
    [201671] = {
        name = "Gory Fur",
    },
    [223814] = {
        name = "Mechanized Lumber Extractor"
    },
    [21562] = {
        name = "Power Word: Fortitude",
    },
    [235313] = {
        name = "Blazing Barrier",
    },
    [381746] = {
        name = "Blessing of the Bronze",
    },
    [360954] = {
        name = "Highland Drake",
    },
    [231390] = {
        name = "Trailblazer",
    },
    [387393] = {
        name = "Dread Calling",
    },
    [376835] = {
        name = "Idol of the Dreamer",
    },
    [394195] = {
        name = "Overflowing Energy",
    },

    [210126] = {
        name = "Arcane Familiar",
    },
    [390224] = {
        name = "Sophic Devotion",
    },
    [282559] = {
        name = "Enlisted",
    },
    [768] = {
        name = "Cat Form",
    },
    [291640] = {
        name = "Transmorphed",
    },
    [425338] = {
        name = "Flourishing Whimsydrake",
    },
    [383783] = {
        name = "Nether Precision",
    },
    [321388] = {
        name = "Enlightened",
    },
    [390636] = {
        name = "Rhapsody",
    },
    [264058] = {
        name = "Mighty Caravan Brutosaur"
    },
    [783] = {
        name = "Travel Form"
    },
    [412359] = { 
        name = "Empowered Temporal Gossamer"
    },
    [400734] = {
        name = "After the Wildfire"
    },
    [381955] = {
        name = "Spoils of Neltharus"
    },
    [404184] = {
        name = "Ground Skimming"
    },
    [388599] = {
        name = "Ride Along"
    },
    [371353] = {
        name = "Elemental Chaos: Frost",
    },
    [388600] = {
        name = "Ride Along"
    },
    [371354] = {
        name = "Phial of the Eye in the Storm"
    },
    [372505] = {
        name = "Ursoc's Fury"
    },
    [388602] = {
        name = "Ride Along"
    },
    [280398] = {
        name = "Sins of the Many"
    },
    [388220] = {
        name = "Calming Coalescence"
    },
    [377234] = {
        name = "Thrill of the Skies"
    },
    [115867] = {
        name = "Mana Tea"
    },
    [403296] = {
        name = "Bronze Attunement"
    },
    [410323] = {
        name = "Glutinous Glitterscale Glob"
    },
    [425910] = {
        name = "Vantus Rune: Nymue"
    },
    [285514] = {
        name = "Surge of Power"
    },
    [400745] = {
        name = "Afterimage"
    },
    [335082] = {
        name = "Frenzy"
    },
    [8679] = {
        name = "Wound Poison"
    },
    [383501] = {
        name = "Firemind"
    },
    [186258] = {
        name = "Aspect of the Cheetah"
    },
    [48018] = {
        name = "Demonic Circle"
    },
    [387336] = {
        name = "Zone of Focus"
    },
    [202164] = {
        name = "Bounding Stride"
    },
    [774] = {
        name = "Rejuvenation"
    },
    [401518] = {
        name = "Bronze Resonance"
    },
    [401519] = {
        name = "Azure Resonance"
    },
    [378269] = {
        name = "Windspeaker's Lava Resurgence"
    },
    [235764] = {
        name = "Darkspore Mana Ray"
    },
    [401521] = {
        name = "Emerald Resonance"
    },
    [406887] = {
        name = "Roused Shadowflame"
    },
    [366646] = {
        name = "Familiar Skies"
    },
    [118522] = {
        name = "Elemental Blast: Critical Strike"
    },
    [372014] = {
        name = "Visage"
    },
    [108366] = {
        name = "Soul Leech"
    },
    [126507] = {
        name = "Depleted-Kyparium Rocket"
    },
    [202425] = {
        name = "Warrior of Elune"
    },
    [121557] = {
        name = "Angelic Feather"
    },
    [5761] = {
        name = "Numbing Poison"
    },
    [122708] = {
        name = "Grand Expedition Yak"
    },
    [383648] = {
        name = "Earth Shield"
    },
    [2645] = {
        name = "Ghost Wolf"
    },
    [388367] = {
        name = "Ohn'ahra's Gusts"
    },
    [378275] = {
        name = "Elemental Equilibrium"
    },
    [388376] = {
        name = "Dragonrider's Compassion"
    },
    [93805] = {
        name = "Ironforge Champion"
    },
    [425935] = {
        name = "Vantus Rune: Igira the Cruel"
    },
    [304062] = {
        name = "Dread Corsair"
    },
    [417888] = {
        name = "Algarian Stormrider"
    },
    [351077] = {
        name = "Second Wind"
    },
    [396174] = {
        name = "Allied Wristguard of Companionship"
    },
    [425940] = {
        name = "Vantus Rune: Smolderon"
    },
    [394003] = {
        name = "Spark of Madness"
    },
    [1850] = {
        name = "Dash"
    },
    [425942] = {
        name = "Vantus Rune: Fyrakk the Blazing"
    },
    [194384] = {
        name = "Atonement"
    },
    [288740] = {
        name = "Priestess' Moonsaber"
    },
    [425305] = {
        name = "Contract: Dream Wardens"
    },
    [425306] = {
        name = "Contract: Dream Wardens"
    },
    [394008] = {
        name = "A Looker's Charm"
    },
    [399502] = {
        name = "Atomically Recalibrated"
    },
    [394009] = {
        name = "Fishing For Attention"
    },
    [425947] = {
        name = "Vantus Rune: Larodar, Keeper of the Flame"
    },
    [394011] = {
        name = "Dressed To Kill"
    },
    [414196] = {
        name = "Awakening"
    },
    [381748] = {
        name = "Blessing of the Bronze"
    },
    [260243] = {
        name = "Volley"
    },
    [415603] = {
        name = "Encapsulated Destiny"
    },
    [390692] = {
        name = "Borrowed Time"
    },
    [394015] = {
        name = "An Eye For Shine"
    },
    [242551] = {
        name = "Fel Focus"
    },
    [173183] = {
        name = "Elemental Blast: Haste"
    },
    [427487] = {
        name = "Ride Along"
    },
    [393763] = {
        name = "Umbral Embrace"
    },
    [347901] = {
        name = "Veiled Augmentation"
    },
    [93811] = {
        name = "Exodar Champion"
    },
    [422382] = {
        name = "Wild Growth"
    },
    [315584] = {
        name = "Instant Poison"
    },
    [308814] = {
        name = "Ny'alotha Allseer"
    },
    [8936] = {
        name = "Regrowth"
    },
    [417275] = {
        name = "Greater Encapsulated Destiny"
    },
    [393897] = {
        name = "Tireless Pursuit"
    },
    [245686] = {
        name = "Fashionable!"
    },
    [410762] = {
        name = "The Silent Star"
    },
    [389684] = {
        name = "Close to Heart"
    },
    [383169] = {
        name = "Lucky Horseshoe"
    },
    [32292] = {
        name = "Swift Purple Gryphon"
    },
    [17481] = {
        name = "Rivendare's Deathcharger"
    },
    [389685] = {
        name = "Generous Pour"
    },
    [397734] = {
        name = "Word of a Worthy Ally"
    },
    [192225] = {
        name = "Coin of Many Faces"
    },
    [383811] = {
        name = "Fevered Incantation"
    },
    [358134] = {
        name = "Star Burst"
    },
    [392883] = {
        name = "Vivacious Vivification"
    },
    [20707] = {
        name = "Soulstone"
    },
    [203277] = {
        name = "Flame Accelerant"
    },
    [48025] = {
        name = "Headless Horseman's Mount"
    },
    [203533] = {
        name = "Black Icey Bling"
    },
    [57821] = {
        name = "Champion of the Kirin Tor"
    },
    [97341] = { 
        name = "Guild Champion", 
    },
    [365362] = {
        name = "Arcane Surge",
    },
    


}