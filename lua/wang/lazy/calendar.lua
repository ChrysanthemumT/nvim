return {
    "calendar",
    dir = "~/projects/plugins/calendar.nvim",
    config = function()
        require('calendar').setup()
        local cal = require('calendar')
        vim.api.nvim_create_user_command("Calendar", cal.render, {})
        vim.keymap.set('n', '<leader>cc', ':Calendar<CR>', {})
    end

}
