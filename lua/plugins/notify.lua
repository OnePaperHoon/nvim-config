return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    
    notify.setup({
      stages = "fade_in_slide_out",
      timeout = 3000,
      max_width = 50,
      background_colour = "#1a1b26",  -- tokyonight 배경
      icons = {
        ERROR = "✘",
        WARN = "▲",
        INFO = "●",
        DEBUG = "◆",
        TRACE = "◇",
      },
      render = "compact",  -- 간결하게
      top_down = true,
      minimum_width = 30,
      fps = 60,
    })
    
    vim.notify = notify
    
    -- 단축키
    vim.keymap.set('n', '<leader>nd', function()
      require("notify").dismiss({ silent = true, pending = true })
    end, { desc = "알림 닫기" })
  end,
}
