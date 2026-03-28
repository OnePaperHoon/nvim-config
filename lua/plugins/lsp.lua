return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- cmp-nvim-lsp capabilities
      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = ok_cmp and cmp_nvim_lsp.default_capabilities() or {}

      -- Neovim 버전 체크
      local nvim_version = vim.version()
      local is_011_or_later = (nvim_version.major > 0) or 
                              (nvim_version.major == 0 and nvim_version.minor >= 11)

      if is_011_or_later then
        -- Neovim 0.11+ 방식 (맥)
        vim.lsp.config("clangd", {
          capabilities = capabilities,
        })
        vim.lsp.enable("clangd")
      else
        -- Neovim 0.10 방식 (라즈베리파이)
        local ok_lsp, lspconfig = pcall(require, "lspconfig")
        if ok_lsp and vim.fn.executable("clangd") == 1 then
          lspconfig.clangd.setup({
            capabilities = capabilities,
          })
        end
      end

      -- 키맵 설정 (공통)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "References" })
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Implementation" })
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
    end,
  },
}

