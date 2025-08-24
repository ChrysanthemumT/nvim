return {
    {
        "LukeSmithxyz/vimling",
        event = "VeryLazy",
        config = function()
            -- Key mappings for vimling functions
            local opts = { silent = true, noremap = true }

            vim.keymap.set("n", "<leader>li", ":call ToggleIPA()<CR>",
                vim.tbl_extend("force", opts, { desc = "Toggle IPA mode" }))

            vim.keymap.set("n", "<leader>ld", ":call ToggleDeadKeys()<CR>",
                vim.tbl_extend("force", opts, { desc = "Toggle dead keys" }))

            vim.keymap.set("n", "<leader>lp", ":call ToggleProse()<CR>",
                vim.tbl_extend("force", opts, { desc = "Toggle prose mode" }))

            vim.keymap.set("n", "<leader>lt", ":call ToggleTrans()<CR>",
                vim.tbl_extend("force", opts, { desc = "Toggle transliteration" }))

            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "markdown", "tex", "txt", "org" },
                group = vim.api.nvim_create_augroup("VimlingAutoEnable", { clear = true }),
                callback = function()
                end,
            })
        end,
    },
}
