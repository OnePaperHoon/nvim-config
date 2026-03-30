return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    local telescope = require('telescope')
    local builtin = require('telescope.builtin')
    
    telescope.setup({
      defaults = {
        file_ignore_patterns = { "node_modules", ".git/" },
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            preview_width = 0.55,
          },
        },
      },
    })
    
    -- 키맵
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
  end,
}
