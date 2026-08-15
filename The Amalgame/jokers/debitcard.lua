
SMODS.Joker{ --Debit Card
    key = "debitcard",
    config = {
        extra = {
            DebtCost = 15,
            dollars0 = 15
        }
    },
    loc_txt = {
        ['name'] = 'Debit Card',
        ['text'] = {
            [1] = '{C:blue}Gain{} {C:money}$15{} when purchased from shop.',
            [2] = '{C:red}Lose {}{C:money}$#1#{} when sold.',
            [3] = '{C:red}Amount lost{} decreases by',
            [4] = '{C:money}$2{} at end of round.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 1,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true },
    in_pool = function(self, args)
        return (
            not args 
            or args.source ~= 'jud' 
            or args.source == 'sho' or args.source == 'buf' or args.source == 'rif' or args.source == 'rta' or args.source == 'sou' or args.source == 'uta' or args.source == 'wra'
        )
        and true
    end,
    
    loc_vars = function(self, info_queue, card)
        
        return {vars = {card.ability.extra.DebtCost}}
    end,
    
    calculate = function(self, card, context)
        if context.buying_card and context.card.config.center.key == self.key and context.cardarea == G.jokers  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars + 15
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "+"..tostring(15), colour = G.C.MONEY})
                    return true
                end
            }
        end
        if context.selling_self  then
            return {
                
                func = function()
                    
                    local current_dollars = G.GAME.dollars
                    local target_dollars = G.GAME.dollars - card.ability.extra.DebtCost
                    local dollar_value = target_dollars - current_dollars
                    ease_dollars(dollar_value)
                    card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-"..tostring(card.ability.extra.DebtCost), colour = G.C.MONEY})
                    return true
                end
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval  then
            if (to_big((card.ability.extra.DebtCost or 0)) > to_big(0) and to_big((card.ability.extra.DebtCost or 0)) <= to_big(0)) then
                return {
                    func = function()
                        card.ability.extra.DebtCost = math.max(0, (card.ability.extra.DebtCost) - 2)
                        return true
                    end,
                    message = "Debt Lowered!",
                    extra = {
                        func = function()
                            local target_joker = card
                            
                            if target_joker then
                                if target_joker.ability.eternal then
                                    target_joker.ability.eternal = nil
                                end
                                target_joker.getting_sliced = true
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        target_joker:start_dissolve({G.C.RED}, nil, 1.6)
                                        return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "Repaid!", colour = G.C.RED})
                            end
                            return true
                        end,
                        colour = G.C.RED
                    }
                }
            end
        end
    end
}