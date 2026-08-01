
SMODS.Joker{ --Stats Card
    key = "statscard",
    config = {
        extra = {
            mult = 0
        }
    },
    loc_txt = {
        ['name'] = 'Stats Card',
        ['text'] = {
            [1] = 'Each Scored card gives {C:red}+1 Mult{} for each card scored before it.',
            [2] = '{C:inactive}(Including retriggers){}'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 5,
        y = 0
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
        
        return {vars = {card.ability.extra.mult}}
    end,
    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            card.ability.extra.mult = (card.ability.extra.mult) + 1
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.after and context.cardarea == G.jokers  then
            return {
                func = function()
                    card.ability.extra.mult = 0
                    return true
                end
            }
        end
    end
}