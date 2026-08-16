
SMODS.Back {
    key = 'scaled_deck',
    pos = { x = 1, y = 0 },
    config = {
    },
    loc_txt = {
        name = 'Scaled Deck',
        text = {
            [1] = 'Start with a {C:spectral,E:1}blueprint {}and {C:money}$0{}.'
        },
    },
    unlocked = true,
    discovered = true,
    no_collection = false,
    atlas = 'CustomDecks',
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()
                
                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                    local new_joker = SMODS.add_card({ set = 'Joker', key = 'j_blueprint' })
                    if new_joker then
                        new_joker:set_edition(nil, true)
                    end
                    G.GAME.joker_buffer = 0
                end
                return true
            end
        }))
        G.GAME.starting_params.dollars = 0
    end
}