-- Dpnpinto NVim configs
-- To get lsp error only here
local vim = vim
-- Disable Mouse
vim.opt.mouse = ""
-- Define colors
vim.cmd("colorscheme retrobox")
-- Get line numbers
vim.o.number = true
-- Get relative numbers
vim.o.relativenumber = true
-- No wrap lines
vim.o.wrap = false
-- For not selecting first option of autocomplete
vim.o.completeopt = "menu,menuone,noselect"
-- Define global key
vim.g.mapleader = " "

-- Don't forget to install the language-servers of the languages fo the lsp
-- For C I use ccls (C language server)
vim.lsp.enable({ "bashls", "lua_ls", "ansiblels", "ccls" })

vim.diagnostic.config({
  virtual_lines = { current_line = true },
})

-- Autocomplete activation
-- Autocmd
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local bufnr  = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    -- native LSP completion (omnifunc + <C-Space>)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })

      vim.keymap.set("i", "<C-Space>", function()
        vim.lsp.completion.get()
      end, { buffer = bufnr })
    end

    -- LSP specific keymaps
    -- gd for go to defenition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    -- ca for code action
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    -- rn to rename
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
    -- lf for line format
    vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { buffer = bufnr })
  end,
})
