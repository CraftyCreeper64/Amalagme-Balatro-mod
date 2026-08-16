
SMODS.Joker{ --Hot Potato
    key = "hotpotato",
    config = {
        extra = {
            xmult0 = 2,
            odds = 7
        }
    },
    loc_txt = {
        ['name'] = 'Hot Potato',
        ['text'] = {
            [1] = '{X:red,C:white}X2{} Mult, {C:green}#1# in #2#{} chance of {C:red}destroying {}',
            [2] = 'the joker to the left when hand is played.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
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
    
    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_amalgame_hotpotato') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                return {
                    Xmult = 2
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_6251e89b', 1, card.ability.extra.odds, 'j_amalgame_hotpotato', false) then
                            local my_pos = nil
                            for i = 1, #G.jokers.cards do
                                if G.jokers.cards[i] == card then
                                    my_pos = i
                                    break
                                end
                            end
                            local target_joker = nil
                            if my_pos and my_pos > 1 then
                                local joker = G.jokers.cards[my_pos - 1]
                                if not SMODS.is_eternal(joker) and not joker.getting_sliced then
                                    target_joker = joker
                                end
                            end
                            
                            if target_joker then
                                target_joker.getting_sliced = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Ka-Boom!", colour = G.C.RED})
                            end
                            
                        end
                        return true
                    end
                }
            end
        end
    end
}