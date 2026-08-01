
SMODS.Joker{ --Amalgame Gift Card
    key = "amalgamegiftcard",
    config = {
        extra = {
            highestrankinhand = 0
        }
    },
    loc_txt = {
        ['name'] = 'Amalgame Gift Card',
        ['text'] = {
            [1] = 'If {C:green}first hand of round{} has only {C:attention}1{} card, gain {C:money}money {}equal',
            [2] = 'to it\'s rank, and create a {C:spades}voucher {}tag.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 19,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
    return {vars = {((function() local max = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id > max then max = card.base.id end end; return max end)() or 0)}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (G.GAME.current_round.hands_played == 0 and to_big(#context.scoring_hand) == to_big(1)) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local tag = Tag("tag_voucher")
                        if tag.name == "Orbital Tag" then
                            local _poker_hands = {}
                            for k, v in pairs(G.GAME.hands) do
                                if v.visible then
                                    _poker_hands[#_poker_hands + 1] = k
                                end
                            end
                            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, "jokerforge_orbital")
                        end
                        tag:set_ability()
                        add_tag(tag)
                        play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                        return true
                    end
                }))
                return {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + (function() local max = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id > max then max = card.base.id end end; return max end)()
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring((function() local max = 0; for _, card in ipairs(G.hand and G.hand.cards or {}) do if card.base.id > max then max = card.base.id end end; return max end)()), colour = G.C.MONEY})
                        return true
                    end,
                    extra = {
                        message = "Created Tag!",
                        colour = G.C.GREEN
                    }
                }
            end
        end
    end
}