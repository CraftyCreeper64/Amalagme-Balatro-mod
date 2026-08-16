
SMODS.Joker{ --Hand Mine
    key = "handmine",
    config = {
        extra = {
            myXmult = 1
        }
    },
    loc_txt = {
         ['name'] = 'Hand Mine',
        ['text'] = {
            [1] = 'This joker gains {X:red,C:white}X0.3{} Mult when a',
            [2] = '{C:attention}#2#{} card is {C:red}destroyed{}.',
            [3] = 'Suit changes when a booster pack',
            [4] = 'is skipped.',
            [5] = 'Currently {X:mult,C:white}X#1#{} Mult.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.myXmult, localize((G.GAME.current_round.targetSuit_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.targetSuit_card or {}).suit or 'Spades']}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.targetSuit_card = { suit = 'Spades' }
    end,
    
    calculate = function(self, card, context)
        if context.remove_playing_cards then
        local matched = 0
        for k, removed_card in ipairs(context.removed) do
            if removed_card:is_suit(G.GAME.current_round.targetSuit_card.suit) then
                matched = matched + 1
            end
        end

        if matched > 0 then
            return {
                func = function()
                    card.ability.extra.myXmult = card.ability.extra.myXmult + (0.3 * matched)
                    return true
                end,
                message = "Upgrade!"
            }
        end
    end
        if context.skipping_booster  then
            if G.playing_cards then
                local valid_targetSuit_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_suit(v) then
                        valid_targetSuit_cards[#valid_targetSuit_cards + 1] = v
                    end
                end
                if valid_targetSuit_cards[1] then
                    local targetSuit_card = pseudorandom_element(valid_targetSuit_cards, pseudoseed('targetSuit' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.targetSuit_card.suit = targetSuit_card.base.suit
                end
            end
            return {
                message = "Shuffled!"
            }
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                Xmult = card.ability.extra.myXmult
            }
        end
    end
}