
SMODS.Consumable {
    key = 'wheel',
    set = 'Spectral',
    pos = { x = 1, y = 0 },
    config = { 
        extra = {
            odds = 4   
        } 
    },
    loc_txt = {
        name = 'Wheel',
        text = {
            [1] = '{C:green}#1# in #2#{} chance to apply {C:dark_edition}Foil{}, {C:dark_edition}Holographic{},',
            [2] = '{C:dark_edition}Polychrome{}, or {C:dark_edition}Negative {}to a random joker.'
        }
    },
    cost = 4,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'c_amalgame_wheel')
        return {vars = {numerator, denominator}}
    end,
    use = function(self, card, area, copier)
    local used_card = copier or card

    
    local eligible = {}
    for i, j in ipairs(G.jokers.cards) do
        if not j.edition then
            eligible[#eligible + 1] = j
        end
    end

    if to_big(#eligible) >= to_big(1) then
        if SMODS.pseudorandom_probability(card, 'group_0_6845efd6', 1, card.ability.extra.odds, 'j_amalgame_wheel', false) then
            local target = pseudorandom_element(eligible, pseudoseed('wheel_target'))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('timpani')
                    used_card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    target:flip()
                    play_sound('card1', 1)
                    target:juice_up(0.3, 0.3)
                    return true
                end
            }))
            delay(0.2)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    local edition = pseudorandom_element({'e_foil','e_holo','e_polychrome','e_negative'}, 'random edition')
                    target:set_edition(edition, true)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    target:flip()
                    play_sound('tarot2', 1, 0.6)
                    target:juice_up(0.3, 0.3)
                    return true
                end
            }))
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.jokers:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
end,
can_use = function(self, card)
    local has_eligible = false
    for i, j in ipairs(G.jokers.cards) do
        if not j.edition then
            has_eligible = true
            break
        end
    end
    return has_eligible
end
}