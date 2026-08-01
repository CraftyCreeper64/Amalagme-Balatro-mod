
SMODS.Enhancement {
    key = 'crazycard',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            card_draw0 = 1
        }
    },
    loc_txt = {
        name = 'Crazy Card',
        text = {
            [1] = 'Draw {C:attention}1{} card when scored'
        }
    },
    atlas = 'CustomEnhancements',
    any_suit = false,
    replace_base_card = false,
    no_rank = false,
    no_suit = false,
    always_scores = false,
    unlocked = true,
    discovered = true,
    no_collection = false,
    weight = 5,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if G.hand and #G.hand.cards > 0 then
                SMODS.draw_cards(1)
            end
            return {
                message = "+"..tostring(1).." Cards Drawn"
            }
        end
    end
}