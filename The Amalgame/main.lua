SMODS.Atlas({
    key = "modicon", 
    path = "ModIcon.png", 
    px = 34,
    py = 34,
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "balatro", 
    path = "balatro.png", 
    px = 333,
    py = 216,
    prefix_config = { key = false },
    atlas_table = "ASSET_ATLAS"
})


SMODS.Atlas({
    key = "CustomJokers", 
    path = "CustomJokers.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomConsumables", 
    path = "CustomConsumables.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomBoosters", 
    path = "CustomBoosters.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomEnhancements", 
    path = "CustomEnhancements.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

SMODS.Atlas({
    key = "CustomSeals", 
    path = "CustomSeals.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
}):register()

SMODS.Atlas({
    key = "CustomDecks", 
    path = "CustomDecks.png", 
    px = 71,
    py = 95, 
    atlas_table = "ASSET_ATLAS"
})

local NFS = require("nativefs")
to_big = to_big or function(a) return a end
lenient_bignum = lenient_bignum or function(a) return a end
-- this function is used to load everything within a folder.-- Jokerforge doesnt use it because it doesnt make loading order easy
local function load_folder(path)
    local files = NFS.getDirectoryItemsInfo(mod_path .. "/" .. path)
    for i = 1, #files do
        local file_name = files[i].name
        if file_name:sub(-4) == ".lua" then
            assert(SMODS.load_file(path .. file_name))()
        end
    end
end
-- load the jokers
if true then
    assert(SMODS.load_file("jokers/jarofwealth.lua"))()
    assert(SMODS.load_file("jokers/ancientknowledge.lua"))()
    assert(SMODS.load_file("jokers/handmine.lua"))()
    assert(SMODS.load_file("jokers/hotpotato.lua"))()
    assert(SMODS.load_file("jokers/debitcard.lua"))()
    assert(SMODS.load_file("jokers/statscard.lua"))()
    assert(SMODS.load_file("jokers/theblender.lua"))()
    assert(SMODS.load_file("jokers/amalgamegiftcard.lua"))()
    assert(SMODS.load_file("jokers/lottocard.lua"))()
    assert(SMODS.load_file("jokers/vipaccess.lua"))()
    assert(SMODS.load_file("jokers/disarm.lua"))()
    assert(SMODS.load_file("jokers/socialsecuritycard.lua"))()
    assert(SMODS.load_file("jokers/buspass.lua"))()
    assert(SMODS.load_file("jokers/parry.lua"))()
    assert(SMODS.load_file("jokers/combustioncat.lua"))()
    assert(SMODS.load_file("jokers/foolishjoker.lua"))()
    assert(SMODS.load_file("jokers/theinconvenientskeleton.lua"))()
    assert(SMODS.load_file("jokers/nuhuh.lua"))()
    assert(SMODS.load_file("jokers/juryduty.lua"))()
    assert(SMODS.load_file("jokers/lethalgambit.lua"))()
    assert(SMODS.load_file("jokers/taxes.lua"))()
end
-- load the consumables
if true then
    assert(SMODS.load_file("consumables/timeloop.lua"))()
    assert(SMODS.load_file("consumables/wheel.lua"))()
    assert(SMODS.load_file("consumables/halooffortune.lua"))()
    assert(SMODS.load_file("consumables/thewheeloffortune.lua"))()
    assert(SMODS.load_file("consumables/wheeloffortnite.lua"))()
    assert(SMODS.load_file("consumables/weeoffortune.lua"))()
end
-- load the enhancements
if true then
    assert(SMODS.load_file("enhancements/crazycard.lua"))()
    assert(SMODS.load_file("enhancements/wheelcard.lua"))()
end

-- load the seals
if true then
    assert(SMODS.load_file("seals/tealseal.lua"))()
    assert(SMODS.load_file("seals/wheelseal.lua"))()
end

-- load the deck
if true then
    assert(SMODS.load_file("decks/clear_deck.lua"))()
    assert(SMODS.load_file("decks/scaled_deck.lua"))()
    assert(SMODS.load_file("decks/stacked_deck.lua"))()
end


-- load boosters
assert(SMODS.load_file("boosters.lua"))()
SMODS.ObjectType({
    key = "amalgame_food",
    cards = {
        ["j_gros_michel"] = true,
        ["j_egg"] = true,
        ["j_ice_cream"] = true,
        ["j_cavendish"] = true,
        ["j_turtle_bean"] = true,
        ["j_diet_cola"] = true,
        ["j_popcorn"] = true,
        ["j_ramen"] = true,
        ["j_selzer"] = true
    },
})

SMODS.ObjectType({
    key = "amalgame_amalgame_jokers",
    cards = {
        ["j_amalgame_jarofwealth"] = true,
        ["j_amalgame_ancientknowledge"] = true,
        ["j_amalgame_handmine"] = true,
        ["j_amalgame_hotpotato"] = true,
        ["j_amalgame_debitcard"] = true,
        ["j_amalgame_statscard"] = true,
        ["j_amalgame_theblender"] = true,
        ["j_amalgame_amalgamegiftcard"] = true,
        ["j_amalgame_lottocard"] = true,
        ["j_amalgame_vipaccess"] = true,
        ["j_amalgame_disarm"] = true,
        ["j_amalgame_socialsecuritycard"] = true,
        ["j_amalgame_buspass"] = true,
        ["j_amalgame_parry"] = true,
        ["j_amalgame_combustioncat"] = true,
        ["j_amalgame_foolishjoker"] = true,
        ["j_amalgame_theinconvenientskeleton"] = true,
        ["j_amalgame_nuhuh"] = true,
        ["j_amalgame_juryduty"] = true,
        ["j_amalgame_lethalgambit"] = true,
        ["j_amalgame_taxes"] = true
    },
})

SMODS.ObjectType({
    key = "amalgame_amalgame_pack",
    cards = {
        ["j_amalgame_jarofwealth"] = true,
        ["j_amalgame_ancientknowledge"] = true,
        ["j_amalgame_handmine"] = true,
        ["j_amalgame_hotpotato"] = true,
        ["j_amalgame_statscard"] = true,
        ["j_amalgame_theblender"] = true,
        ["j_amalgame_amalgamegiftcard"] = true,
        ["j_amalgame_lottocard"] = true,
        ["j_amalgame_vipaccess"] = true,
        ["j_amalgame_disarm"] = true,
        ["j_amalgame_socialsecuritycard"] = true,
        ["j_amalgame_buspass"] = true,
        ["j_amalgame_parry"] = true,
        ["j_amalgame_foolishjoker"] = true,
        ["j_amalgame_theinconvenientskeleton"] = true,
        ["j_amalgame_nuhuh"] = true,
        ["j_amalgame_juryduty"] = true,
        ["j_amalgame_taxes"] = true
    },
})


SMODS.current_mod.optional_features = function()
    return {
        cardareas = {} 
    }
end