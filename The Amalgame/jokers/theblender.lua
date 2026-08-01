
SMODS.Joker{ --The Blender
    key = "theblender",
    config = {
        extra = {
            blenderMult = 0,
            enhancedcardsinhand = 1
        }
    },
    loc_txt = {
        ['name'] = 'The Blender',
        ['text'] = {
            [1] = '{X:red,C:white}X1{} Mult, plus an additional {X:red,C:white}X0.3{}',
            [2] = 'for each {C:enhanced}Enhanced{} card held in hand.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
    return {vars = {card.ability.extra.blenderMult, card.ability.extra.enhancedcardsinhand + (((function() local count = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do if next(SMODS.get_enhancements(card)) then count = count + 1 end end; return count end)() or 0)) * 0.3}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
            Xmult = card.ability.extra.enhancedcardsinhand + ((function() local count = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do if next(SMODS.get_enhancements(card)) then count = count + 1 end end; return count end)()) * 0.3
            }
        end
    end
}