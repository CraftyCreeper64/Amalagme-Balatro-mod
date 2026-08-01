
SMODS.Joker{ --The Inconvenient Skeleton
    key = "theinconvenientskeleton",
    config = {
        extra = {
            mult0 = 25
        }
    },
    loc_txt = {
        ['name'] = 'The Inconvenient Skeleton',
        ['text'] = {
            [1] = '{C:red}+25{} Mult if played hand contains a ({C:dark_edition}?????{})',
            [2] = '{C:inactive}(????? is a random  poker hand that changes',
            [3] = '{}{C:inactive}at end of round.){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 7,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {localize((G.GAME.current_round.skeletonHand_hand or 'High Card'), 'poker_hands')}}
    end,
    
    set_ability = function(self, card, initial)
        G.GAME.current_round.skeletonHand_hand = 'High Card'
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if next(context.poker_hands[G.GAME.current_round.skeletonHand_hand]) then
                return {
                    mult = 25
                }
            end
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            local skeletonHand_hands = {}
            for handname, _ in pairs(G.GAME.hands) do
                if G.GAME.hands[handname].visible then
                    skeletonHand_hands[#skeletonHand_hands + 1] = handname
                end
            end
            if skeletonHand_hands[1] then
                G.GAME.current_round.skeletonHand_hand = pseudorandom_element(skeletonHand_hands, pseudoseed('skeletonHand' .. G.GAME.round_resets.ante))
            end
            return {
                message = "Skeletonized!"
            }
        end
    end
}