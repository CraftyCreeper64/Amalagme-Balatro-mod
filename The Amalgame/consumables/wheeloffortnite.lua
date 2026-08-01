
SMODS.Consumable {
    key = 'wheeloffortnite',
    set = 'Tarot',
    pos = { x = 4, y = 0 },
    config = { 
        extra = {
            odds = 4,
            dollars0 = 19   
        } 
    },
    loc_txt = {
        name = 'Wheel of Fortnite',
        text = {
            [1] = '{C:green}#1# in #2#{} chance of gaining {C:money}$19{}.'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'c_amalgame_wheeloffortnite')
        return {vars = {numerator, denominator}}
    end,
    use = function(self, card, area, copier)
        local used_card = copier or card
        if SMODS.pseudorandom_probability(card, 'group_0_2ea7f7b6', 1, card.ability.extra.odds, 'j_amalgame_wheeloffortnite', false) then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + 19
                    local dollar_value = target_dollars - current_dollars
                    card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "Who wants it?", colour = G.C.RED})
                    ease_dollars(dollar_value, true)
                    return true
                end
            }))
            delay(0.6)
            
        else
            card_eval_status_text(used_card, 'extra', nil, nil, nil, {message = "Nope!", colour = G.C.PURPLE})
        end
    end,
    can_use = function(self, card)
        return true
    end
}