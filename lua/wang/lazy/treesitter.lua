return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",

	dependencies = {
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			branch = "main",
		},
	},

	config = function()
		----------------------------------------------------------------------
		-- nvim-treesitter
		----------------------------------------------------------------------

		require("nvim-treesitter").setup({
			install_dir = vim.fn.stdpath("data") .. "/site",
		})

		-- Install parsers
		require("nvim-treesitter").install({
			"vimdoc",
			"javascript",
			"typescript",
			"c",
			"cpp",
			"lua",
			"rust",
			"jsdoc",
			"bash",
			"markdown",
			"markdown_inline",
		})

		----------------------------------------------------------------------
		-- Treesitter highlighting
		----------------------------------------------------------------------

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"vimdoc",
				"javascript",
				"typescript",
				"c",
				"cpp",
				"lua",
				"rust",
				"jsdoc",
				"bash",
				"markdown",
				"templ",
			},
			callback = function()
				vim.treesitter.start()
			end,
		})

		----------------------------------------------------------------------
		-- Treesitter indentation
		----------------------------------------------------------------------

		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"javascript",
				"typescript",
				"c",
				"cpp",
				"lua",
				"rust",
				"bash",
				"markdown",
				"templ",
			},
			callback = function()
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})

		----------------------------------------------------------------------
		-- nvim-treesitter-textobjects
		----------------------------------------------------------------------

		require("nvim-treesitter-textobjects").setup({
			select = {
				lookahead = true,

				selection_modes = {
					["@function.outer"] = "V",
					["@class.outer"] = "V",
				},
			},

			move = {
				set_jumps = true,
			},
		})

		local select_textobject = require("nvim-treesitter-textobjects.select").select_textobject

		local goto_next_start = require("nvim-treesitter-textobjects.move").goto_next_start

		local goto_next_end = require("nvim-treesitter-textobjects.move").goto_next_end

		local goto_previous_start = require("nvim-treesitter-textobjects.move").goto_previous_start

		local goto_previous_end = require("nvim-treesitter-textobjects.move").goto_previous_end

		----------------------------------------------------------------------
		-- Select textobjects
		----------------------------------------------------------------------

		local textobject_keymaps = {
			["af"] = "@function.outer",
			["if"] = "@function.inner",
			["ac"] = "@class.outer",
			["ic"] = "@class.inner",
			["aa"] = "@parameter.outer",
			["ia"] = "@parameter.inner",
		}

		for lhs, query in pairs(textobject_keymaps) do
			vim.keymap.set({ "x", "o" }, lhs, function()
				select_textobject(query, "textobjects")
			end)
		end

		----------------------------------------------------------------------
		-- Move between functions/classes
		----------------------------------------------------------------------

		vim.keymap.set({ "n", "x", "o" }, "]f", function()
			goto_next_start("@function.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]c", function()
			goto_next_start("@class.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]F", function()
			goto_next_end("@function.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "]C", function()
			goto_next_end("@class.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[f", function()
			goto_previous_start("@function.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[c", function()
			goto_previous_start("@class.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[F", function()
			goto_previous_end("@function.outer", "textobjects")
		end)

		vim.keymap.set({ "n", "x", "o" }, "[C", function()
			goto_previous_end("@class.outer", "textobjects")
		end)

		----------------------------------------------------------------------
		-- Swap parameters
		----------------------------------------------------------------------

		vim.keymap.set("n", "<leader>a", function()
			require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner")
		end)

		vim.keymap.set("n", "<leader>A", function()
			require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
		end)

		----------------------------------------------------------------------
		-- Templ
		----------------------------------------------------------------------

		vim.api.nvim_create_autocmd("User", {
			pattern = "TSUpdate",
			callback = function()
				require("nvim-treesitter.parsers").templ = {
					install_info = {
						url = "https://github.com/vrischmann/tree-sitter-templ.git",
						branch = "master",
						files = {
							"src/parser.c",
							"src/scanner.c",
						},
					},
				}
			end,
		})

		vim.treesitter.language.register("templ", "templ")

		----------------------------------------------------------------------
		-- Markdown highlighting
		----------------------------------------------------------------------

		vim.api.nvim_set_hl(0, "@markup.heading.5.markdown", { fg = "#f4a6a3", bold = true })

		vim.api.nvim_set_hl(0, "@markup.heading.6.markdown", { fg = "#f9c5a6", bold = true })

		vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { fg = "#f9e5a6", bold = true })

		vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { fg = "#b8ddb8", bold = true })

		vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { fg = "#a6d4f4", bold = true })

		vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { fg = "#d4b8dd", bold = true })

		vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { fg = "#ffc2e2", bold = true })

		vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { fg = "#b8ddb8", italic = true })

		vim.api.nvim_set_hl(0, "@markup.strikethrough.markdown_inline", { fg = "#888888", strikethrough = true })

		vim.api.nvim_set_hl(0, "@markup.link.label.markdown_inline", { fg = "#a6c4f4", underline = true })

		vim.api.nvim_set_hl(0, "@markup.link.url.markdown_inline", { fg = "#b8d4f4" })

		vim.api.nvim_set_hl(0, "@markup.raw.markdown_inline", { fg = "#a6e4e4", bg = "#3a3f4b" })

		vim.api.nvim_set_hl(0, "@markup.raw.block.markdown", { fg = "#a6e4e4", bg = "#3a3f4b" })

		vim.api.nvim_set_hl(0, "@markup.list.markdown", { fg = "#d4b8dd" })

		vim.api.nvim_set_hl(0, "@markup.quote.markdown", { fg = "#b4b8c4", italic = true })
	end,
}
