
SMODS.Joker{ --Social Security Card
    key = "socialsecuritycard",
    config = {
        extra = {
            xmult0 = 3
        }
    },
    loc_txt = {
        ['name'] = 'Social Security Card',
        ['text'] = {
            [1] = '{X:red,C:white}X3{} Mult if played hand is a Secret hand.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if (next(context.poker_hands["Flush House"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Five of a Kind"])) then
                return {
                    Xmult = 3
                }
            end
        end
    end
}