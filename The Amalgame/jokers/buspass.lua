
SMODS.Joker{ --Bus Pass
    key = "buspass",
    config = {
        extra = {
            repetitions0 = 1
        }
    },
    loc_txt = {
        ['name'] = 'Bus Pass',
        ['text'] = {
            [1] = '{C:attention}Retrigger{} all played cards if played',
            [2] = 'hand contains {C:orange}no face cards{}.'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'CustomJokers',
    pools = { ["amalgame_amalgame_jokers"] = true, ["amalgame_amalgame_pack"] = true },
    
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play  then
            if (function()
                local count = 0
                for _, playing_card in pairs(context.full_hand or {}) do
                    if playing_card:is_face() then
                        count = count + 1
                    end
                end
                return count == 0
            end)() then
                return {
                    repetitions = 1,
                    message = localize('k_again_ex')
                }
            end
        end
    end
}