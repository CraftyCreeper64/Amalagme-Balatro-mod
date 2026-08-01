
SMODS.Seal {
    key = 'wheelseal',
    pos = { x = 1, y = 0 },
    config = {
        extra = {
            odds = 2
        }
    },
    badge_colour = HEX('FFD700'),
    loc_txt = {
        name = 'Wheel Seal',
        label = 'Wheel Seal',
        text = {
            [1] = '{C:green}#1# in #2#{} chance to retrigger {C:attention}2{} times when played.'
        }
    },
    atlas = 'CustomSeals',
    unlocked = true,
    discovered = true,
    no_collection = false,
    sound = { sound = "coin1", per = 1.2, vol = 0.4 },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.seal.extra.odds, 'j_amalgame_wheelseal')
        return {vars = {numerator, denominator}}
    end,
calculate = function(self, card, context)
    if context.repetition and context.cardarea == G.play then
        if SMODS.pseudorandom_probability(card, 'group_0_85e51b40', 1, card.ability.seal.extra.odds, 'j_amalgame_wheelseal', false) then
            return {
                message = localize('k_again_ex'),
                repetitions = 2,
            }
        end
    end
end
}