return {
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require('nightfox').setup({
                options = {
                    transparent     = true,
                    terminal_colors = true,
                }
            })

            vim.cmd("colorscheme nordfox")
        end
    },
}
