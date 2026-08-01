
SMODS.Booster {
    key = 'amalgame_pack',
    loc_txt = {
        name = "Amalgame Pack",
        text = {
            [1] = 'Choose {C:attention}1{} of up to {C:attention}2{} {X:planet,C:white}Amalgame{} cards',
            [2] = ''
        },
        group_name = "Amalgame Pack"
    },
    config = { extra = 2, choose = 1 },
    atlas = "CustomBoosters",
    pos = { x = 0, y = 0 },
    discovered = true,
    loc_vars = function(self, info_queue, card)
        local cfg = (card and card.ability) or self.config
        return {
            vars = { cfg.choose, cfg.extra }
        }
    end,
    create_card = function(self, card, i)
        return {
            set = "amalgame_amalgame_pack",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
            key_append = "amalgame_amalgame_pack"
        }
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("17898c"))
        ease_background_colour({ new_colour = HEX('17898c'), special_colour = HEX("0e5193"), contrast = 2 })
    end,
    particles = function(self)
        -- No particles for joker packs
        end,
    }
    
    
    SMODS.Booster {
        key = 'wheel_pack',
        loc_txt = {
            name = "Wheel Pack",
            text = {
                [1] = 'Choose {C:attention}1{} of up to {C:attention}2{} {C:tarot}wheel {}cards to use immediately'
            },
            group_name = "amalgame_boosters"
        },
        config = { extra = 2, choose = 1 },
        atlas = "CustomBoosters",
        pos = { x = 1, y = 0 },
        select_card = "consumeables",
        discovered = true,
        loc_vars = function(self, info_queue, card)
            local cfg = (card and card.ability) or self.config
            return {
                vars = { cfg.choose, cfg.extra }
            }
        end,
        create_card = function(self, card, i)
            local weights = {
                3,
                1,
                1,
                1,
                1,
                1
            }
            local total_weight = 0
            for _, weight in ipairs(weights) do
                total_weight = total_weight + weight
            end
            local random_value = pseudorandom('amalgame_wheel_pack_card') * total_weight
            local cumulative_weight = 0
            local selected_index = 1
            for j, weight in ipairs(weights) do
                cumulative_weight = cumulative_weight + weight
                if random_value <= cumulative_weight then
                    selected_index = j
                    break
                end
            end
            if selected_index == 1 then
                return {
                    key = "c_wheel_of_fortune",
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "amalgame_wheel_pack"
                }
            elseif selected_index == 2 then
                return {
                    key = "c_amalgame_wheel",
                    set = "Planet",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "amalgame_wheel_pack"
                }
            elseif selected_index == 3 then
                return {
                    key = "c_amalgame_halooffortune",
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "amalgame_wheel_pack"
                }
            elseif selected_index == 4 then
                return {
                    key = "c_amalgame_weeoffortune",
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "amalgame_wheel_pack"
                }
            elseif selected_index == 5 then
                return {
                    key = "c_amalgame_wheeloffortnite",
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "amalgame_wheel_pack"
                }
            elseif selected_index == 6 then
                return {
                    key = "c_amalgame_thesealoffortune",
                    set = "Tarot",
                    area = G.pack_cards,
                    skip_materialize = true,
                    soulable = true,
                    key_append = "amalgame_wheel_pack"
                }
            end
        end,
        particles = function(self)
            G.booster_pack_sparkles = Particles(1, 1, 0, 0, {
                timer = 0.015,
                scale = 0.2,
                initialize = true,
                lifespan = 1,
                speed = 1.1,
                padding = -1,
                attach = G.ROOM_ATTACH,
                colours = { G.C.WHITE, lighten(G.C.PURPLE, 0.4), lighten(G.C.PURPLE, 0.2), lighten(G.C.GOLD, 0.2) },
                fill = true
            })
            G.booster_pack_sparkles.fade_alpha = 1
            G.booster_pack_sparkles:fade(1, 0)
        end,
    }
    