return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      size = 15,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false,  -- 터미널 배경 음영 끄기
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      persist_mode = true,
      direction = "horizontal",
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = {
        border = "curved",
        width = 120,
        height = 30,
      },
    })
    
    -- 키맵
    vim.keymap.set('n', '<leader>tt', ':ToggleTerm<CR>', { desc = "터미널" })
    vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float<CR>', { desc = "플로팅 터미널" })
    
    -- 터미널 모드 키맵
    vim.keymap.set('t', '<Esc><Esc>', [[<C-\><C-n>]], { desc = "Normal 모드" })
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], { desc = "왼쪽 창" })
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], { desc = "아래 창" })
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], { desc = "위 창" })
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], { desc = "오른쪽 창" })
    
    -- 빠른 명령어 함수
    local Terminal = require("toggleterm.terminal").Terminal
    
    -- lazygit 터미널
    local lazygit = Terminal:new({
      cmd = "lazygit",
      direction = "float",
      hidden = true,
    })
    
    function _LAZYGIT_TOGGLE()
      lazygit:toggle()
    end
    
    vim.keymap.set('n', '<leader>tg', '<cmd>lua _LAZYGIT_TOGGLE()<CR>', { desc = "Lazygit" })
  end,
}
