
SMODS.Back {
    key = 'clear_deck',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            remove_starting_cards_count0 = 52
        },
    },
    loc_txt = {
        name = 'Clear Deck',
        text = {
            [1] = 'Start with {C:red}no cards{} in deck.',
            [2] = 'Start with a {C:spectral}Holographic{} {C:attention}Certificate{} and {C:attention}Marble Joker{}.'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                for i=#G.deck.cards, 1, -1 do
                    G.deck.cards[i]:remove()
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('timpani')
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_certificate' })
                    if new_joker then
                        new_joker:set_edition("e_holo", true)
                    end
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('timpani')
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_marble' })
                    if new_joker then
                    end
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
    end
}