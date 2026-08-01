
SMODS.Joker{ --Combustion Cat
    key = "combustioncat",
    config = {
        extra = {
        }
    },
    loc_txt = {
        ['name'] = 'Combustion Cat',
        ['text'] = {
            [1] = 'Converts all played cards to {C:attention}Glass{}.',
            [2] = 'Whenever one or more {C:attention}Glass{} cards {C:red}break{},',
            [3] = 'add a random card with a random {C:spectral}seal {}to hand.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 20,
    rarity = 4,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true },
    soul_pos = {
        x = 5,
        y = 1
    },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'sho' and args.source ~= 'buf' and args.source ~= 'jud' 
            or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            local scored_card = context.other_card
            G.E_MANAGER:add_event(Event({
                func = function()
                    
                    scored_card:set_ability(G.P_CENTERS.m_glass)
                    card_eval_status_text(scored_card, 'extra', nil, nil, nil, {message = "Card Modified!", colour = G.C.ORANGE})
                    return true
                end
            }))
        end
        if context.remove_playing_cards  then
            if (function()
                for k, removed_card in ipairs(context.removed) do
                    if removed_card.shattered then
                        return true
                    end
                end
                return false
            end)() then
                return {
                    func = function()
                        local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                        local base_card = create_playing_card({
                            front = card_front,
                            center = G.P_CENTERS.c_base
                        }, G.discard, true, false, nil, true)
                        
                        base_card:set_seal(pseudorandom_element({'Gold','Red','Blue','Purple','amalgame_tealseal','amalgame_wheelseal'}, pseudoseed('add_card_hand_seal')), true)
                        
                        
                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        base_card.playing_card = G.playing_card
                        table.insert(G.playing_cards, base_card)
                        
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.hand:emplace(base_card)
                                base_card:start_materialize()
                                SMODS.calculate_context({ playing_card_added = true, cards = { base_card } })
                                return true
                            end
                        }))
                    end,
                    message = "Added Card to Hand!"
                }
            end
        end
    end
}