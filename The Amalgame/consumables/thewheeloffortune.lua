
SMODS.Consumable {
    key = 'thesealoffortune',
    set = 'Tarot',
    pos = { x = 3, y = 0 },
    loc_txt = {
        name = 'Seal of Fortune',
        text = {
            [1] = 'Add a {C:gold}Wheel Seal{} to {C:attention}1{} random card in hand'
        }
    },
    cost = 3,
    unlocked = true,
    discovered = true,
    hidden = false,
    can_repeat_soul = false,
    atlas = 'CustomConsumables',
    use = function(self, card, area, copier)
    local used_card = copier or card
    local affected_cards = {}
    local temp_hand = {}

    for _, playing_card in ipairs(G.hand.cards) do
        if not playing_card.seal then
            temp_hand[#temp_hand + 1] = playing_card
        end
    end

    table.sort(temp_hand,
        function(a, b)
            return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card
        end
    )

    pseudoshuffle(temp_hand, 12345)

    for i = 1, math.min(1, #temp_hand) do
        affected_cards[#affected_cards + 1] = temp_hand[i]
    end

    if #affected_cards == 0 then return end

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
            play_sound('tarot1')
            used_card:juice_up(0.3, 0.5)
            return true
        end
    }))
    for i = 1, #affected_cards do
        local percent = 1.15 - (i - 0.999) / (#affected_cards - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                affected_cards[i]:flip()
                play_sound('card1', percent)
                affected_cards[i]:juice_up(0.3, 0.3)
                return true
            end
        }))
    end
    delay(0.2)
    for i = 1, #affected_cards do
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                affected_cards[i]:set_seal("amalgame_wheelseal", nil, true)
                return true
            end
        }))
    end
    for i = 1, #affected_cards do
        local percent = 0.85 + (i - 0.999) / (#affected_cards - 0.998) * 0.3
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
                affected_cards[i]:flip()
                play_sound('tarot2', percent, 0.6)
                affected_cards[i]:juice_up(0.3, 0.3)
                return true
            end
        }))
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
            G.hand:unhighlight_all()
            return true
        end
    }))
    delay(0.5)
end,
can_use = function(self, card)
    for _, playing_card in ipairs(G.hand.cards) do
        if not playing_card.seal then
            return true
        end
    end
    return false
end
}