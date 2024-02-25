function ColorMyPencils(color)
	color = "nordfox"
	vim.cmd.colorscheme(color)

end

return {
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require('nightfox').setup({
                disable_background = true,
            })

            vim.cmd("colorscheme nordfox")

            ColorMyPencils()
        end
    },
}
