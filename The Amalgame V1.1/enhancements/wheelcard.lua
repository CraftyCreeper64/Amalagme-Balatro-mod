
SMODS.Enhancement {
    key = 'wheelcard',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            odds = 4
        }
    },
    loc_txt = {
        name = 'Wheel Card',
        text = {
            [1] = '{C:green}#1# in #2#{} chance to become {C:dark_edition}foil{}, {C:dark_edition}holographic{},',
            [2] = 'or {C:dark_edition}polychrome {}when scored, and remove enhancement.'
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
    loc_vars = function(self, info_queue, card)
         local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_amalgame_wheelcard')
        return {vars = {numerator, denominator}}
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'group_0_e7de5bcb', 1, card.ability.extra.odds, 'j_amalgammmmmmmme_wheelcard', false) then
                card:set_ability(G.P_CENTERS.c_base)
                local random_edition = poll_edition('edit_card_edition', nil, true, true)
                if random_edition then
                    card:set_edition(random_edition, true)
                    
                end
                
            end
        end
    end
}