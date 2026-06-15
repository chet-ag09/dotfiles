hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 25,

        border_size = 2,

        col = {
            active_border   = { colors = {"rgba(33ccffee)"}},
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 20,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 0.8,
        inactive_opacity = 0.7,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 10,
            passes    = 3,
            vibrancy  = 0.42,
        },
    },

    animations = {
        enabled = true,
    },
})
