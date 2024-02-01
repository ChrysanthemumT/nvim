-- PDF Viewer:
-- http://manpages.ubuntu.com/manpages/trusty/man5/zathurarc.5.html
vim.g['vimtex_view_method'] = 'skim'
vim.g['vimtex_quickfix_mode'] =0

vim.g.maplocalleader = " "

-- Ignore mappings
vim.g['vimtex_mappings_enabled'] = 0

vim.keymap.set('n', '<Space>ll', ":VimtexCompile<CR>", {})
vim.keymap.set('n', '<Space>lv', ":VimtexView<CR>", {})

-- Auto Indent
vim.g['vimtex_indent_enabled'] = 0
 

-- Syntax highlighting
vim.g['vimtex_syntax_enabled'] = 1

-- Error suppression:
-- https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt

vim.g['vimtex_log_ignore'] = ({
  'Underfull',
  'Overfull',
  'specifier changed to',
  'Token not allowed in a PDF string',
})

vim.g.maplocalleader = " "

vim.g['vimtex_context_pdf_viewer'] = 'skim'

-- vim.g['vimtex_complete_enabled'] = 1
-- vim.g['vimtex_compiler_progname'] = 'nvr'
-- vim.g['vimtex_complete_close_braces'] = 1
vim.api.nvim_exec([[ 
  function! s:TexFocusVim() abort
    " Replace `TERMINAL` with the name of your terminal application
    " Example: execute "!open -a iTerm"  
    " Example: execute "!open -a Alacritty"
    silent execute "!open -a iTerm"
    redraw!
  endfunction
  augroup vimtex_event_focus
    au!
    au User VimtexEventViewReverse call s:TexFocusVim()
  augroup END
]], false)
