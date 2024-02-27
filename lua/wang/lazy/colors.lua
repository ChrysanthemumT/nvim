return {
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require('nightfox').setup({
                options = {
                    transparent  = true,
                    terminal_colors = true,
                }
            })

            vim.cmd("colorscheme nordfox")

        end
    },
    {
        "olivercederborg/poimandres.nvim",
        config = function()
            require('poimandres').setup {
                disable_background = true,
                disable_float_background = true,
            }
            --vim.cmd("colorscheme poimandres")
        end
    }
}
