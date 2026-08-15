
SMODS.Joker{ --Parry
    key = "parry",
    config = {
        extra = {
            housesPlayed = 0,
            mult0 = 10,
        }
    },
    loc_txt = {
        ['name'] = 'Parry',
        ['text'] = {
            [1] = 'If played hand is a full house, {C:red}+10{} Mult.',
            [2] = 'Gain {C:money}$1{} for each {C:red}consecutive {}full house played.',
            [3] = '{C:inactive}Currently{} {C:money}+$#1#{}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.housesPlayed or 0}}
    end,

    calculate = function(self, card, context)
        
        if context.cardarea == G.jokers and context.joker_main  then
            card.ability.extra.housesPlayed = card.ability.extra.housesPlayed or 0
            if next(context.poker_hands["Full House"]) then
                card.ability.extra.housesPlayed = (card.ability.extra.housesPlayed) + 1
                return {
                    message = "Upgrade!",
                    extra = {
                        mult = 10,
                        extra = {
                            
                            func = function()
                                
                                local current_dollars = G.GAME.dollars
                                local target_dollars = G.GAME.dollars + card.ability.extra.housesPlayed
                                local dollar_value = target_dollars - current_dollars
                                ease_dollars(dollar_value)
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(card.ability.extra.housesPlayed), colour = G.C.MONEY})
                                return true
                            end,
                            colour = G.C.MONEY
                        }
                    }
                }
            elseif not next(context.poker_hands["Full House"]) then
                card.ability.extra.housesPlayed = 0
            end
        end
    end
}