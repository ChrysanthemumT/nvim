return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup({
            -- A list of parser names, or "all"
            ensure_installed = {
                "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                "jsdoc", "bash",
            },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
            auto_install = true,

            indent = {
                enable = true
            },

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },
        })

        local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
        treesitter_parser_config.templ = {
            install_info = {
                url = "https://github.com/vrischmann/tree-sitter-templ.git",
                files = { "src/parser.c", "src/scanner.c" },
                branch = "master",
            },
        }

        vim.treesitter.language.register("templ", "templ")
        vim.api.nvim_set_hl(0, '@markup.heading.5.markdown', { fg = '#f4a6a3', bold = true })
        vim.api.nvim_set_hl(0, '@markup.heading.6.markdown', { fg = '#f9c5a6', bold = true })
        vim.api.nvim_set_hl(0, '@markup.heading.1.markdown', { fg = '#f9e5a6', bold = true })
        vim.api.nvim_set_hl(0, '@markup.heading.4.markdown', { fg = '#b8ddb8', bold = true })
        vim.api.nvim_set_hl(0, '@markup.heading.2.markdown', { fg = '#a6d4f4', bold = true })
        vim.api.nvim_set_hl(0, '@markup.heading.3.markdown', { fg = '#d4b8dd', bold = true })

        vim.api.nvim_set_hl(0, '@markup.strong.markdown_inline', { fg = '#ffc2e2', bold = true })
        vim.api.nvim_set_hl(0, '@markup.italic.markdown_inline', { fg = '#b8ddb8', italic = true })
        vim.api.nvim_set_hl(0, '@markup.strikethrough.markdown_inline', { fg = '#c4c9d4', strikethrough = true })

        vim.api.nvim_set_hl(0, '@markup.link.label.markdown_inline', { fg = '#a6c4f4', underline = true })
        vim.api.nvim_set_hl(0, '@markup.link.url.markdown_inline', { fg = '#b8d4f4' })

        vim.api.nvim_set_hl(0, '@markup.raw.markdown_inline', { fg = '#a6e4e4', bg = '#3a3f4b' })
        vim.api.nvim_set_hl(0, '@markup.raw.block.markdown', { fg = '#a6e4e4', bg = '#3a3f4b' })

        vim.api.nvim_set_hl(0, '@markup.list.markdown', { fg = '#d4b8dd' })
        vim.api.nvim_set_hl(0, '@markup.quote.markdown', { fg = '#b4b8c4', italic = true })
    end
}
