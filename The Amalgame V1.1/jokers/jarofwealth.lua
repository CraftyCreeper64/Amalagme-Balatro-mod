
SMODS.Joker{ --Jar of Wealth
    key = "jarofwealth",
    config = {
        extra = {
            card_draw0 = 2
        }
    },
    loc_txt = {
        ['name'] = 'Jar of Wealth',
        ['text'] = {
            [1] = 'When drawing {C:attention}first hand of round{}, draw {C:clubs}2{} additional cards.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    calculate = function(self, card, context)
        if context.first_hand_drawn  then
            if G.hand and #G.hand.cards > 0 then
                SMODS.draw_cards(2)
            end
            return {
                message = "Summoned!"
            }
        end
    end
}