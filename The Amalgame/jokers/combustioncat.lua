
SMODS.Joker{ --Combustion Cat
    key = "combustioncat",
    config = {
        extra = {
        }
    },
    loc_txt = {
         ['name'] = 'Combustion Cat',
        ['text'] = {
            [1] = 'Converts all played {C:1}#1#{} cards to {C:attention}Glass{}.',
            [2] = 'Whenever one or more {C:attention}Glass{} cards {C:red}break{},',
            [3] = 'add a {C:green,E:1}random {}card with a {C:green,E:1}random {}{C:spectral}seal {}to hand.',
            [4] = '{C:inactive}(Suit changes at end of round){}'
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
    eternal_compat = false,
    perishable_compat = false,
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
    loc_vars = function(self, info_queue, card)
        
        return {vars = {localize((G.GAME.current_round.glassSuit_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.glassSuit_card or {}).suit or 'Spades']}}
    end,
    set_ability = function(self, card, initial)
    if not G.GAME.current_round.glassSuit_card then
        local valid_cards = {}
        if G.playing_cards then
            for _, v in ipairs(G.playing_cards) do
                if not SMODS.has_no_suit(v) then
                    valid_cards[#valid_cards + 1] = v
                end
            end
        end
        if valid_cards[1] then
            local pick = pseudorandom_element(valid_cards, pseudoseed('glassSuit_init'))
            G.GAME.current_round.glassSuit_card = { suit = pick.base.suit }
        else
            G.GAME.current_round.glassSuit_card = { suit = pseudorandom_element({'Spades', 'Hearts', 'Clubs', 'Diamonds'}, pseudoseed('glassSuit_init')) }
        end
    end
end,

calculate = function(self, card, context)
    -- defensive fallback: guarantees this is never nil, even if current_round got reset
    if not G.GAME.current_round.glassSuit_card then
        G.GAME.current_round.glassSuit_card = { suit = pseudorandom_element({'Spades', 'Hearts', 'Clubs', 'Diamonds'}, pseudoseed('glassSuit_fallback')) }
    end

    if context.individual and context.cardarea == G.play then
        if context.other_card:is_suit(G.GAME.current_round.glassSuit_card.suit) then
            context.other_card:set_ability(G.P_CENTERS.m_glass)
        end
    end

    if context.remove_playing_cards then
        local matched = 0
        for k, removed_card in ipairs(context.removed) do
            if removed_card.shattered then
                matched = matched + 1
            end
        end

        if matched > 0 then
            return {
                func = function()
                    local added_cards = {}

                    for i = 1, matched do
                        local card_front = pseudorandom_element(G.P_CARDS, pseudoseed('add_card_hand'))
                        local base_card = create_playing_card({
                            front = card_front,
                            center = G.P_CENTERS.c_base
                        }, G.discard, true, false, nil, true)

                        base_card:set_seal(pseudorandom_element({'Gold','Red','Blue','Purple','amalgame_tealseal','amalgame_wheelseal'}, pseudoseed('add_card_hand_seal_' .. i)), true)

                        G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                        base_card.playing_card = G.playing_card
                        table.insert(G.playing_cards, base_card)
                        table.insert(added_cards, base_card)
                    end

                    G.E_MANAGER:add_event(Event({
                        func = function()
                            for _, c in ipairs(added_cards) do
                                G.hand:emplace(c)
                                c:start_materialize()
                            end
                            SMODS.calculate_context({ playing_card_added = true, cards = added_cards })
                            return true
                        end
                    }))

                    return true
                end,
                message = "Added Card!"
            }
        end
    end

    if context.end_of_round and context.game_over == false and context.main_eval then
        local current_suit = G.GAME.current_round.glassSuit_card.suit
        local all_suits = {'Spades', 'Hearts', 'Clubs', 'Diamonds'}
        local other_suits = {}
        for _, s in ipairs(all_suits) do
            if s ~= current_suit then
                other_suits[#other_suits + 1] = s
            end
        end
        G.GAME.current_round.glassSuit_card.suit = pseudorandom_element(other_suits, pseudoseed('glassSuit' .. G.GAME.round_resets.ante))
        return {
            message = "Reset!"
        }
    end
end,

loc_vars = function(self, info_queue, card)
    return {vars = {localize((G.GAME.current_round.glassSuit_card or {}).suit or 'Spades', 'suits_singular')}, colours = {G.C.SUITS[(G.GAME.current_round.glassSuit_card or {}).suit or 'Spades']}}
end,

}