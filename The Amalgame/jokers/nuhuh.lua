
SMODS.Joker{ --Nuh-Uh
    key = "nuhuh",
    config = {
        extra = {
            myChips = 0
        }
    },
    loc_txt = {
        ['name'] = 'Nuh-Uh',
        ['text'] = {
            [1] = 'At end of shop, {C:red}destroys {}a random',
            [2] = 'consumable to gain {C:blue}+20{} chips.',
            [3] = 'Currently {C:blue}+#1#{} Chips'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 8,
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
        
        return {vars = {card.ability.extra.myChips}}
    end,
    
    calculate = function(self, card, context)
        if context.ending_shop  then
            if to_big(#G.consumeables.cards) > to_big(0) then
                return {
                    func = function()
                        local target_cards = {}
                        for i, consumable in ipairs(G.consumeables.cards) do
                            table.insert(target_cards, consumable)
                        end
                        if #target_cards > 0 then
                            local card_to_destroy = pseudorandom_element(target_cards, pseudoseed('destroy_consumable'))
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    card_to_destroy:start_dissolve()
                                    return true
                                end
                            }))
                            card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Countered!", colour = G.C.RED})
                        end
                        return true
                    end,
                    extra = {
                        func = function()
                            card.ability.extra.myChips = (card.ability.extra.myChips) + 20
                            return true
                        end,
                        colour = G.C.GREEN
                    }
                }
            end
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                chips = card.ability.extra.myChips
            }
        end
    end
}