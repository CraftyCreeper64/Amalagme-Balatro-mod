
SMODS.Joker{ --Hand Mine
    key = "handmine",
    config = {
        extra = {
            myXmult = 1
        }
    },
    loc_txt = {
        ['name'] = 'Hand Mine',
        ['text'] = {
            [1] = 'Gains {X:red,C:white}X0.5{} Mult for each #2# played this round.',
            [2] = '{C:inactive}(Resets at end of round){}',
            [3] = 'Currently {X:red,C:white}X#1#{} Mult'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Joker',
    pools = { ["amalgame_amalgame_jokers"] = true, ["aamalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.myXmult, localize((G.GAME.current_round.targetRank_card or {}).rank or 'Ace', 'ranks')}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.targetRank_card = { rank = '7', id = 7 }
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if G.playing_cards then
                local valid_targetRank_cards = {}
                for _, v in ipairs(G.playing_cards) do
                    if not SMODS.has_no_rank(v) then
                        valid_targetRank_cards[#valid_targetRank_cards + 1] = v
                    end
                end
                if valid_targetRank_cards[1] then
                    local targetRank_card = pseudorandom_element(valid_targetRank_cards, pseudoseed('targetRank' .. G.GAME.round_resets.ante))
                    G.GAME.current_round.targetRank_card.rank = targetRank_card.base.value
                    G.GAME.current_round.targetRank_card.id = targetRank_card.base.id
                end
            end
            return {
                func = function()
                    card.ability.extra.myXmult = 1
                    return true
                end
            }
        end
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                Xmult = card.ability.extra.myXmult
            }
        end
        if context.individual and context.cardarea == G.play  then
            if context.other_card:get_id() == 14 then
                card.ability.extra.myXmult = (card.ability.extra.myXmult) + 0.5
            end
        end
    end
}