
SMODS.Joker{ --Jury Duty
    key = "juryduty",
    config = {
        extra = {
            odds = 6,
            xmult0 = 3,
            dollars0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Jury Duty',
        ['text'] = {
            [1] = '{X:red,C:white}X3{} Mult and {C:attention}-$1{} when hand is played.',
            [2] = '{C:green}1 in 6{} chance to {C:red}self-destruct{} at end of round.',
            [3] = '{C:inactive}(Can\'t be sold){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 9,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_amalgame_juryduty') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    set_ability = function(self, card, initial)
        card:set_eternal(true)
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_b9232be8', 1, card.ability.extra.odds, 'j_amalgame_juryduty', false) then
                    SMODS.calculate_effect({func = function()
                        local target_joker = card
                        
                        if target_joker then
                            if target_joker.ability.eternal then
                                target_joker.ability.eternal = nil
                            end
                            target_joker.getting_sliced = true
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Destroyed!", colour = G.C.RED})
                        end
                        return true
                    end}, card)
                end
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = 3,
                extra = {
                    
                    func = function()
                        
                        local current_dollars = G.GAME.dollars
                        local target_dollars = G.GAME.dollars - 1
                        local dollar_value = target_dollars - current_dollars
                        ease_dollars(dollar_value)
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(1), colour = G.C.MONEY})
                        return true
                    end,
                    colour = G.C.MONEY
                }
            }
        end
    end
}