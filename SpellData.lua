local addonName, addon = ...

-- Default list to watch for. These are spells with modifiers that we need to account for.
-- Possible modifiers are: damageAddition, damageMultiplier, reductionModifier, magicReductionModifier, physicalReductionModifier
addon.defaultTracked = {
    
		[23456] = {
			["physicalReductionModifier"] = 0.1,
			["name"] = "Example Spell",
			["damageMultiplier"] = 1.2,
			["magicReductionModifier"] = 0.1,
			["reductionModifier"] = 0.1,
			["damageAddition"] = 0.1,
		},
		[183435] = {
			["name"] = "Retribution Aura",
			["damageMultiplier"] = 1.05,
		},
		[48107] = {
			["name"] = "Heating Up",
			["damageMultiplier"] = 1.05,
		},
		[260286] = {
			["damageAddition"] = 0.02,
			["name"] = "Tip of the Spear",
			["damageMultiplier"] = 1,
		},
		[216331] = {
			["name"] = "Avenging Crusader",
			["damageMultiplier"] = 1.2,
		},
		[32182] = {
			["name"] = "Heroism",
			["damageAddition"] = 0.2,
		},
		[260734] = {
			["name"] = "Master of the Elements",
			["damageMultiplier"] = 1.1,
		},
		[45438] = {
			["name"] = "Ice Block",
			["reductionModifier"] = 1,
		},
		[6940] = {
			["name"] = "Blessing of Sacrifice",
			["reductionModifier"] = 0.3,
		},
		[248622] = {
			["description"] = "Colossus Smash increases your Haste by 10%, or by 20% if the target is below 35% health. Lasts 10 sec.",
			["name"] = "In For The Kill",
			["damageAddition"] = 0.04,
		},
		[373183] = {
			["name"] = "Harsh Discipline",
			["damageMultiplier"] = 1.05,
		},
		[387336] = {
			["name"] = "Zone of Focus",
			["reductionModifier"] = 0.05,
		},
		[104773] = {
			["name"] = "Unending Resolve",
			["reductionModifier"] = 0.25,
		},
		[61336] = {
			["name"] = "Survival Instincts",
			["reductionModifier"] = 0.5,
		},
		[391099] = {
			["name"] = "Dark Evangelism",
			["damageMultiplier"] = 1.02,
		},
		[264173] = {
			["name"] = "Demonic Core",
			["damageMultiplier"] = 1.1,
		},
		[122783] = {
			["name"] = "Diffuse Magic",
			["magicReductionModifier"] = 0.6,
		},
		[258920] = {
			["name"] = "Immolation Aura",
			["damageMultiplier"] = 1.05,
		},
		[197625] = {
			["physicalReductionModifier"] = 0.125,
			["name"] = "Moonkin Form",
			["damageMultiplier"] = 1.1,
		},
		[102543] = {
			["name"] = "Incarnation: Avatar of Ashamane",
			["damageMultiplier"] = 1.2,
		},
		[114050] = {
			["name"] = "Ascendance",
			["damageAddition"] = 0.1,
		},
		[315496] = {
			["damageAddition"] = 0.09,
			["name"] = "Slice and Dice",
			["damageMultiplier"] = 1.05,
		},
		[42650] = {
			["description"] = "Summons a legion of ghouls who swarms your enemies, fighting anything they can for 30 sec.",
			["name"] = "Army of the Dead",
			["damageAddition"] = 1.15,
		},
		[210918] = {
			["name"] = "Ethereal Form",
			["damageAddition"] = 0,
		},
		[386196] = {
			["physicalReductionModifier"] = -0.05,
			["name"] = "Berserker Stance",
			["damageMultiplier"] = 1.1,
		},
		[390978] = {
			["name"] = "Twist of Fate",
			["description"] = "After damaging or healing a target below 35% health, gain 5% increased damage and healing for 8 sec.",
		},
		[213915] = {
			["name"] = "Mass Spell Reflection",
			["magicReductionModifier"] = 1,
		},
		[31884] = {
			["name"] = "Avenging Wrath",
			["damageMultiplier"] = 1.2,
		},
		[102560] = {
			["name"] = "Incarnation: Chosen of Elune - burst",
			["damageMultiplier"] = 1.29,
		},
		[53480] = {
			["name"] = "Roar of Sacrifice (pet)",
			["reductionModifier"] = 0.2,
		},
		[196098] = {
			["damageAddition"] = 0.2,
			["name"] = "Soul Harvest",
			["damageMultiplier"] = 1,
		},
		[391109] = {
			["name"] = "Dark Ascension",
			["damageAddition"] = 0.1,
			["description"] = "Increases your non-periodic Shadow damage by 25% for 20 sec.\r\n\r\n|cFFFFFFFFGenerates 30 Insanity.|r",
		},
		[116267] = {
			["name"] = "Incanter's Flow",
			["damageMultiplier"] = 1.02,
		},
		[48707] = {
			["name"] = "Anti-Magic Shell",
			["magicReductionModifier"] = 0,
		},
		[193358] = {
			["name"] = "Grand Melee",
			["damageMultiplier"] = 1.05,
		},
		[406921] = {
			["name"] = "Adaptive Stonescales",
			["physicalReductionModifier"] = 0.05,
		},
		[202602] = {
			["name"] = "Into the Fray",
			["damageAddition"] = 0.05,
		},
		[5217] = {
			["name"] = "Tiger's Fury",
			["damageMultiplier"] = 1.15,
		},
		[22812] = {
			["damageAddition"] = 0,
			["reductionModifier"] = 0.2,
			["name"] = "Barkskin",
		},
		[393919] = {
			["name"] = "Screams of the Void",
			["description"] = "Devouring Plague causes your Shadow Word: Pain and Vampiric Touch to deal damage 40% faster on all targets for 3 sec.",
		},
		[383018] = {
			["name"] = "Stoneskin",
			["physicalReductionModifier"] = 0.1,
		},
		[47568] = {
			["description"] = "Empower your rune weapon, gaining 15% Haste and generating 1 Rune and 5 Runic Power instantly and every 5 sec for 20 sec.\r\n",
			["name"] = "Empower Rune Weapon",
			["reductionModifier"] = 1.15,
		},
		[5487] = {
			["name"] = "Bear Form",
			["physicalReductionModifier"] = 0.3,
		},
		[371353] = {
			["name"] = "Elemental Chaos: Frost",
			["damageMultiplier"] = 1.05,
		},
		[394049] = {
			["description"] = "Balance of All Things\nInstant",
			["name"] = "Balance of All Things",
			["damageAddition"] = 0.03,
		},
		[209426] = {
			["name"] = "Darkness",
			["reductionModifier"] = 0.5,
			["damageAddition"] = 0,
		},
		[391882] = {
			["name"] = "Apex Predator's Craving",
			["damageMultiplier"] = 1.1,
		},
		[212295] = {
			["physicalReductionModifier"] = 0,
			["name"] = "Nether Ward",
			["magicReductionModifier"] = 1,
		},
		[394050] = {
			["description"] = "Balance of All Things\nInstant",
			["name"] = "Balance of All Things",
			["damageAddition"] = 0.03,
		},
		[118038] = {
			["physicalReductionModifier"] = 0.1,
			["reductionModifier"] = 0.3,
			["name"] = "Die by the Sword",
		},
		[17] = {
			["name"] = "Power Word: Shield",
			["reductionModifier"] = 0.1,
		},
		[385126] = {
			["name"] = "Blessing of Dusk",
			["description"] = "Damage taken reduced by 5% For 10 sec.",
		},
		[93622] = {
			["name"] = "Gore",
			["damageAddition"] = 0,
			["damageMultiplier"] = 1.05,
		},
		[23920] = {
			["name"] = "Spell Reflection",
			["magicReductionModifier"] = 0.2,
		},
		[396092] = {
			["name"] = "Well Fed",
			["damageMultiplier"] = 1.03,
		},
		[48517] = {
			["description"] = "Casting 2 Starfires empowers Wrath for 15 sec. Casting 2 Wraths empowers Starfire for 15 sec.\r\n\r\n|T236152:24|t |cffffffffEclipse (Solar)|r\r\nNature spells deal 15% additional damage and Wrath damage is increased by 40%.\r\n\r\n|T236151:24|t |cffffffffEclipse (Lunar)|r\r\nArcane spells deal 15% additional damage and the damage Starfire deals to nearby enemies is increased by 30%.",
			["name"] = "Eclipse (Solar)",
			["damageMultiplier"] = 1.15,
		},
		[392778] = {
			["description"] = "Haste increased by 1% and your auto-attack critical strikes increase your auto-attack speed by 10% for 10 sec.",
			["name"] = "Wild Strikes",
			["damageAddition"] = 0.01,
		},
		[381623] = {
			["description"] = "Restore 100 Energy. Mastery increased by 4.8% for 6 sec.",
			["name"] = "Thistle Tea",
			["damageAddition"] = 0.03,
		},
		[47585] = {
			["name"] = "Dispersion",
			["reductionModifier"] = 0.75,
		},
		[232698] = {
			["name"] = "Shadowform",
			["damageMultiplier"] = 1.06,
		},
		[3408] = {
			["name"] = "Crippling Poison",
			["physicalReductionModifier"] = 0.1,
		},
		[12042] = {
			["name"] = "Arcane Power",
			["damageMultiplier"] = 1.3,
		},
		[86659] = {
			["name"] = "Guardian of Ancient Kings",
			["reductionModifier"] = 0.5,
		},
		[371172] = {
			["reductionModifier"] = 0.02,
			["name"] = "Phial of Tepid Versatility",
			["damageMultiplier"] = 1.02,
		},
		[5277] = {
			["name"] = "Evasion",
			["physicalReductionModifier"] = 0.5,
		},
		[121164] = {
			["name"] = "Orb of Power",
			["damageAddition"] = 0.1,
		},
		[408340] = {
			["name"] = "Shadows of the Predator",
			["damageAddition"] = 0.01,
		},
		[1966] = {
			["name"] = "Feint",
			["reductionModifier"] = 0.1,
		},
		[129914] = {
			["name"] = "Power Strikes",
			["damageAddition"] = 0.05,
		},
		[48518] = {
			["description"] = "Casting 2 Starfires empowers Wrath for 15 sec. Casting 2 Wraths empowers Starfire for 15 sec.\r\n\r\n|T236152:24|t |cffffffffEclipse (Solar)|r\r\nNature spells deal 15% additional damage and Wrath damage is increased by 40%.\r\n\r\n|T236151:24|t |cffffffffEclipse (Lunar)|r\r\nArcane spells deal 15% additional damage and the damage Starfire deals to nearby enemies is increased by 30%.",
			["name"] = "Eclipse (Lunar)",
			["damageMultiplier"] = 1.15,
		},
		[108271] = {
			["name"] = "Astral shift",
			["reductionModifier"] = 0.4,
		},
		[287280] = {
			["name"] = "Glimmer of Light",
			["damageAddition"] = 0.05,
		},
		[31224] = {
			["name"] = "Cloak of Shadows",
			["magicReductionModifier"] = 1,
		},
		[256735] = {
			["description"] = "Critical strike chance increased by 30% while Stealthed and for 3 sec after breaking Stealth.",
			["name"] = "Master Assassin",
			["damageAddition"] = 0.2,
		},
		[345230] = {
			["name"] = "Gladiator's Insignia",
			["damageMultiplier"] = 1.1,
		},
		[124974] = {
			["name"] = "Nature's Vigil",
			["reductionModifier"] = 0.05,
		},
		[16166] = {
			["name"] = "Elemental Mastery - burst",
			["damageAddition"] = 0.2,
		},
		[382079] = {
			["name"] = "Incarnate's Mark of Frost",
			["damageMultiplier"] = 1.05,
		},
		[382080] = {
			["name"] = "Incarnate's Mark of Fire",
			["damageMultiplier"] = 1.05,
		},
		[228049] = {
			["name"] = "Guardian of the Forgotten Queen",
			["reductionModifier"] = 1,
		},
		[19574] = {
			["name"] = "Bestial Wrath",
			["damageMultiplier"] = 1.25,
		},
		[226807] = {
			["name"] = "Well Fed",
			["damageMultiplier"] = 1.03,
		},
		[200183] = {
			["name"] = "Apotheosis",
			["damageMultiplier"] = 1.3,
		},
		[395152] = {
			["name"] = "Ebon Might",
			["description"] = "Increase your 4 nearest allies' primary stat by 6.5% of your own, and cause you to deal 20% more damage, for 10 sec.\r\n\r\nMay only affect 4 allies at once, and prefers to imbue damage dealers.\r\n\r\nEruption, Deep Breath, and your empower spells extend the duration of these effects.",
			["damageMultiplier"] = 1.2,
		},
		[198529] = {
			["name"] = "Plunder Armor",
			["damageAddition"] = 0.05,
		},
		[390581] = {
			["description"] = "While Bladestorming, every 0.8 sec you gain 5% movement speed and 5% Strength, stacking up to 6 times. Lasts 6 sec. \r\n\r\nBladestorm cannot be canceled while using Hurricane.",
			["name"] = "Hurricane",
			["damageAddition"] = 0.05,
		},
		[386164] = {
			["name"] = "Battle Stance",
			["damageMultiplier"] = 1.03,
		},
		[207319] = {
			["name"] = "Corpse Shield",
			["reductionModifier"] = 0.9,
		},
		[383997] = {
			["name"] = "Arcane Tempo",
			["damageMultiplier"] = 1.02,
		},
		[175784] = {
			["name"] = "Well Fed",
			["damageMultiplier"] = 1.05,
		},
		[383269] = {
			["description"] = "Abomination Limb\n20 yd range\nInstant",
			["name"] = "Abomination Limb",
			["reductionModifier"] = 1.15,
		},
		[196099] = {
			["name"] = "Grimoire of Sacrifice",
			["damageMultiplier"] = 1.1,
		},
		[1022] = {
			["name"] = "Blessing of Protection",
			["physicalReductionModifier"] = 1,
		},
		[204018] = {
			["name"] = "Blessing of Spellwarding",
			["magicReductionModifier"] = 1,
		},
		[193538] = {
			["name"] = "Alacrity",
			["damageMultiplier"] = 1.01,
		},
		[257622] = {
			["damageAddition"] = 0,
			["name"] = "Trick Shots",
			["damageMultiplier"] = 1.05,
		},
		[198589] = {
			["physicalReductionModifier"] = 0.2,
			["reductionModifier"] = 0.2,
			["name"] = "Blur",
		},
		[122278] = {
			["name"] = "Dampen Harm",
			["reductionModifier"] = 0.3,
		},
		[79140] = {
			["name"] = "Vendetta",
			["damageMultiplier"] = 1.3,
		},
		[106951] = {
			["name"] = "Berserk - burst",
			["damageMultiplier"] = 1.25,
		},
		[198144] = {
			["name"] = "Ice form (pvp)",
			["damageMultiplier"] = 1.15,
		},
		[204288] = {
			["name"] = "Earth Shield",
			["reductionModifier"] = 0.1,
		},
		[48792] = {
			["name"] = "Icebound Fortitude",
			["reductionModifier"] = 0.3,
		},
		[90355] = {
			["name"] = "Ancient Hysteria",
			["damageAddition"] = 0.2,
		},
		[186265] = {
			["name"] = "Aspect of the Turtle",
			["reductionModifier"] = 1,
		},
		[465] = {
			["name"] = "Devotion Aura",
			["reductionModifier"] = 0.03,
		},
		[381664] = {
			["name"] = "Amplifying Poison",
			["damageMultiplier"] = 1.05,
		},
		[382153] = {
			["name"] = "Well Fed",
			["damageMultiplier"] = 1.03,
		},
		[102342] = {
			["name"] = "Ironbark",
			["reductionModifier"] = 0.2,
		},
		[12472] = {
			["name"] = "Icy Veins",
			["damageAddition"] = 0.14,
		},
		[418810] = {
			["name"] = "Dreamsurge Lone Wolves",
			["description"] = "Increases damage done, healing done, and movement speed by 25% and decreases damage taken by 25% while not near another player.",
		},
		[382154] = {
			["name"] = "Well Fed",
			["damageMultiplier"] = 1.05,
		},
		[642] = {
			["name"] = "Divine Shield",
			["reductionModifier"] = 1,
		},
		[10060] = {
			["name"] = "Power Infusion",
			["damageAddition"] = 0.2,
		},
		[121471] = {
			["name"] = "Shadow Blades",
			["damageMultiplier"] = 1.2,
		},
		[33206] = {
			["name"] = "Pain Suppression",
			["reductionModifier"] = 0.4,
		},
		[279709] = {
			["description"] = "Starsurge and Starfall grant you 2% Haste for 15 sec.\r\n\r\nStacks up to 3 times. Gaining a stack does not refresh the duration.",
			["name"] = "Starlord",
			["damageMultiplier"] = 1.02,
		},
		[199261] = {
			["name"] = "Death Wish",
			["damageAddition"] = 0.1,
		},
		[257946] = {
			["name"] = "Thrill of the Hunt",
			["damageMultiplier"] = 1.05,
		},
		[115176] = {
			["name"] = "Zen Meditation",
			["reductionModifier"] = 0.6,
		},
		[115192] = {
			["name"] = "Subterfuge",
			["description"] = "Your abilities requiring Stealth can still be used for 3 sec after Stealth breaks.",
		},
		[31230] = {
			["name"] = "Cheat Death (cd)",
			["reductionModifier"] = 0.85,
		},
		[418813] = {
			["name"] = "Self Sufficient",
			["description"] = "Increases damage done, healing done, and movement speed by 25% and decreases damage taken by 25% while not near another player.",
		},
		[498] = {
			["name"] = "Divine Protection",
			["reductionModifier"] = 0.2,
		},
		[194223] = {
			["name"] = "Celestial Alignment - burst",
			["damageMultiplier"] = 1.25,
		},
		[107574] = {
			["name"] = "Avatar",
			["damageMultiplier"] = 1.2,
		},
		[80353] = {
			["name"] = "Time Warp",
			["damageMultiplier"] = 1.3,
		},
		[264663] = {
			["name"] = "Predator's Thirst",
			["reductionModifier"] = 0.1,
		},
		[393438] = {
			["name"] = "Draconic Augmentation",
			["damageMultiplier"] = 1.04,
		},
		[162264] = {
			["name"] = "Metamorphosis",
			["damageMultiplier"] = 1.2,
		},
		[13750] = {
			["name"] = "Adrenaline Rush",
			["damageMultiplier"] = 1.09,
		},
		[24858] = {
			["physicalReductionModifier"] = 0.125,
			["name"] = "Moonkin Form",
			["damageMultiplier"] = 1.1,
		},
		[391528] = {
			["name"] = "Convoke the Spirits",
			["description"] = "Call upon the Night Fae for an eruption of energy, channeling a rapid flurry of 16 Druid spells and abilities over 4 sec.\r\n\r\nYou will cast Wild Growth, Swiftmend, Moonfire, Wrath, Regrowth, Rejuvenation, Rake, and Thrash on appropriate nearby targets, favoring your current shapeshift form.",
		},
		[390192] = {
			["name"] = "Ragefire",
			["damageMultiplier"] = 1.1,
		},
		[224668] = {
			["name"] = "Crusade",
			["damageAddition"] = 0,
		},
		[374000] = {
			["name"] = "Iced Phial of Corrupting Rage",
			["damageMultiplier"] = 1.03,
		},
		[196555] = {
			["name"] = "Netherwalk",
			["reductionModifier"] = 1,
		},
		[33891] = {
			["physicalReductionModifier"] = 0.2,
			["name"] = "Incarnation: Tree of Life",
			["damageMultiplier"] = 1.2,
		},
		[386208] = {
			["name"] = "Defensive Stance",
			["reductionModifier"] = 0.1,
		},
		[356661] = {
			["name"] = "Chaotic Imprint - Fire",
			["damageMultiplier"] = 1.1,
		},
		[385127] = {
			["damageAddition"] = 0.05,
			["name"] = "Blessing of Dawn",
			["damageMultiplier"] = 1,
		},
		[190319] = {
			["name"] = "Combustion - burst",
			["damageMultiplier"] = 1.3,
		},
		[383883] = {
			["name"] = "Fury of the Sun King",
			["damageMultiplier"] = 1.15,
		},
		[374002] = {
			["name"] = "Corrupting Rage",
			["damageMultiplier"] = 1.03,
		},
		[2823] = {
			["name"] = "Deadly Poison",
			["damageAddition"] = 0.03,
		},
		[401187] = {
			["name"] = "Molten Overflow",
			["damageMultiplier"] = 1.1,
		},
		[45182] = {
			["name"] = "Cheating Death",
			["reductionModifier"] = 0.85,
		},
		[1126] = {
			["name"] = "Mark of the Wild",
			["damageMultiplier"] = 1.03,
		},
		[2825] = {
			["name"] = "Bloodlust",
			["damageAddition"] = 0.2,
		},
		[395296] = {
			["description"] = "Ebon Might\nInstant",
			["name"] = "Ebon Might",
			["damageAddition"] = 0,
			["damageMultiplier"] = 1.2,
		},
		[160452] = {
			["name"] = "Netherwinds",
			["damageAddition"] = 0.2,
		},
		[199754] = {
			["name"] = "Riposte",
			["physicalReductionModifier"] = 0.2,
		},
		[175785] = {
			["name"] = "Well Fed",
			["damageMultiplier"] = 1.05,
		},
		[1719] = {
			["name"] = "Battle Cry",
			["damageMultiplier"] = 1.15,
		},
		[871] = {
			["name"] = "Warrior Shield Wall",
			["reductionModifier"] = 0.4,
			["damageMultiplier"] = 1,
		},
		[205766] = {
			["name"] = "Bone Chilling",
			["damageAddition"] = 0.01,
			["description"] = "Bone Chilling\nInstant",
		},
	
}

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