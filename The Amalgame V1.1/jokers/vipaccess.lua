
SMODS.Joker{ --VIP Access
    key = "vipaccess",
    config = {
        extra = {
            shop_slots_increase = '1',
            booster_slots_increase = '1'
        }
    },
    loc_txt = {
        ['name'] = 'VIP Access',
        ['text'] = {
            [1] = '{C:attention}+1{} Shop slot',
            [2] = '{C:attention}+1{} Booster pack slot',
            [3] = ''
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    calculate = function(self, card, context)
    end,
    
    add_to_deck = function(self, card, from_debuff)
        change_shop_size(1)
        SMODS.change_booster_limit(1)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        change_shop_size(-1)
        SMODS.change_booster_limit(-1)
    end
}