
SMODS.Joker{ --Foolish Joker
    key = "foolishjoker",
    config = {
        extra = {
            legChance = 0
        }
    },
    loc_txt = {
        ['name'] = 'Foolish Joker',
        ['text'] = {
            [1] = 'Create a random {C:tarot}tarot{} card when a {C:attention}7{} is discarded'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 5,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.legChance}}
    end,
    
    calculate = function(self, card, context)
        if context.discard  then
            if context.other_card:get_id() == 7 then
                return {
                    func = function()
                        
                        for i = 1, math.min(1, G.consumeables.config.card_limit - #G.consumeables.cards) do
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.4,
                                
                                func = function()
                                    if G.consumeables.config.card_limit - #G.consumeables.cards > 0 then
                                        play_sound('timpani')
                                        SMODS.add_card({ set = 'Tarot' })
                                        card:juice_up(0.3, 0.5)
                                    end
                                    return true
                                end
                            }))
                        end
                        delay(0.6)
                        
                        if created_consumable then
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "You Fool!", colour = G.C.PURPLE})
                        end
                        return true
                    end
                }
            end
        end
    end
}