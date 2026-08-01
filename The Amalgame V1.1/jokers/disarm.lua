
SMODS.Joker{ --Disarm
    key = "disarm",
    config = {
        extra = {
            odds = 4
        }
    },
    loc_txt = {
        ['name'] = 'Disarm',
        ['text'] = {
            [1] = '{C:green}#1# in #2#{} chance to {C:red}prevent death{} and self destruct.',
            [2] = '{C:attention}Sell this joker{} to create a random {C:purple}tag{}.',
            [3] = '{C:inactive}(preventing death doesn\'t work in Multiplayer){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 1
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
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 3, card.ability.extra.odds, 'j_amalgame_disarm') 
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.selling_self  then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local selected_tag = pseudorandom_element(G.P_TAGS, pseudoseed("create_tag")).key
                            local tag = Tag(selected_tag)
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
                    return true
                end,
                message = "Created Tag!"
            }
        end
        if context.end_of_round and context.game_over and context.main_eval  then
            if true then
                if SMODS.pseudorandom_probability(card, 'group_0_27b38624', 3, card.ability.extra.odds, 'j_amalgame_disarm', false) then
                    SMODS.calculate_effect({saved = true}, card)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_saved_ex'), colour = G.C.RED})
                    SMODS.calculate_effect({func = function()
                        local target_joker = card
                        
                        if target_joker then
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
    end
}