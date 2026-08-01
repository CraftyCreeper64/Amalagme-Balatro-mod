
SMODS.Consumable {
    key = 'halooffortune',
    set = 'Planet',
    pos = { x = 2, y = 0 },
    config = { 
        extra = {
            odds = 4   
        } 
    },
    loc_txt = {
        name = 'Halo of Fortune',
        text = {
            [1] = '{C:green}#1# in #2#{} chance to create',
            [2] = '{C:attention}2{} random {C:dark_edition}negative{} {C:planet}planet{} cards'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'c_amalgame_halooffortune')
        return {vars = {numerator, denominator}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if SMODS.pseudorandom_probability(card, 'group_0_c8ea32a9', 1, card.ability.extra.odds, 'j_amalgame_halooffortune', false) then
            for i = 1, 2 do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        if G.consumeables.config.card_limit > #G.consumeables.cards + G.GAME.consumeable_buffer then
                            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        end
                        
                        
                        play_sound('timpani')
                        SMODS.add_card({ set = 'Planet', edition = 'e_negative', })                            
                        used_card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            end
            delay(0.6)
            
            if created_consumable then
                card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet})
            end
            return true
            
        end
    end,
    can_use = function(self, card)
        return true
    end
}