
SMODS.Joker{ --Ancient Knowledge
    key = "ancientknowledge",
    config = {
        extra = {
            active = 0,
            card_draw0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Ancient Knowledge',
        ['text'] = {
            [1] = 'On {C:hearts}final hand{} of round, draw {C:green}three{} extra cards'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.active}}
    end,
    
    calculate = function(self, card, context)
        if context.hand_drawn  then
            if to_big(G.GAME.current_round.hands_left) <= to_big(1) then
                if G.hand and #G.hand.cards > 0 then
                    SMODS.draw_cards(3)
                end
                return {
                    message = "+"..tostring(3).." Cards Drawn"
                }
            end
        end
    end
}