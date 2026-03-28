return {
  {
    "neovim/nvim-lspconfig",
    -- Neovim 0.10에서만 버전 고정 (경고 제거)
    version = vim.fn.has('nvim-0.11') == 0 and "v1.2.0" or nil,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = ok_cmp and cmp_nvim_lsp.default_capabilities() or {}

      -- vim.lsp.config 존재 여부로 분기
      if vim.lsp.config then
        -- Neovim 0.11+ (맥)
        if vim.fn.executable("clangd") == 1 then
          vim.lsp.config("clangd", {
            capabilities = capabilities,
          })
          vim.lsp.enable("clangd")
        end
      else
        -- Neovim 0.10 (라즈베리파이)
        local ok_lsp, lspconfig = pcall(require, "lspconfig")
        if ok_lsp and vim.fn.executable("clangd") == 1 then
          lspconfig.clangd.setup({
            capabilities = capabilities,
          })
        end
      end

      -- 키맵 (공통)
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