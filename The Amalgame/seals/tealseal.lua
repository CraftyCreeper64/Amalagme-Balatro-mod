
SMODS.Seal {
    key = 'tealseal',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            xchips0 = 1.5
        }
    },
    badge_colour = HEX('40E0D0'),
    loc_txt = {
        name = 'Teal Seal',
        label = 'Teal Seal',
        text = {
            [1] = '{X:blue,C:white}X1.5{} {C:blue}Chips {}while held in hand.'
        }
    },
    atlas = 'CustomSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,
    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.main_scoring then
            return {
                x_chips = 1.5
            }
        end
    end
}