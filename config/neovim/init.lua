vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/nvim-mini/mini.diff" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-mini/mini.extra" },
  { src = "https://github.com/nvim-mini/mini.icons" },
  { src = "https://github.com/hrsh7th/nvim-cmp" },
  { src = "https://github.com/hrsh7th/cmp-nvim-lsp" },
  { src = "https://github.com/hrsh7th/cmp-path" },
  { src = "https://github.com/hrsh7th/cmp-buffer" },
  { src = "https://github.com/iamcco/markdown-preview.nvim" },
})

vim.g.mapleader = " "

require("vague").setup({
  -- bold = false,
  transparent = false,
})

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.winborder = "rounded"
vim.opt.wrap = true
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.completeopt = { "menu", "menuone", "noselect" }

require "mini.pick".setup()
require "mini.diff".setup()
require "mini.pairs".setup()
require "mini.extra".setup()
require "mini.icons".setup()

local cmp = require('cmp')
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

vim.api.nvim_set_hl(0, "MiniPickNormal", { link = "Normal" })
vim.api.nvim_set_hl(0, 'MiniPickBorder', { link = 'Normal' })

vim.keymap.set("n", "<leader>ff", function() require("mini.pick").builtin.files() end)
vim.keymap.set("n", "<leader>fg", function() require("mini.pick").builtin.grep_live() end)
vim.keymap.set("n", "<leader>fb", function() require("mini.pick").builtin.buffers() end)
vim.keymap.set("n", "<leader>fh", function() require("mini.pick").builtin.help() end)
vim.keymap.set("n", "<leader>fq", function() require("mini.extra").pickers.list({ scope = "quickfix" }) end)
vim.keymap.set("n", "<leader>od", function() require("mini.extra").pickers.diagnostic({ scope = "current" }) end)
vim.keymap.set("n", "<leader>mp", ":MarkdownPreviewToggle<CR>")

vim.lsp.config("*", {
  root_markers = { ".git" },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my.lsp", {}),
  callback = function(args)
    local opts = { buffer = args.buf, remap = false }
    local map = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, opts) end

    map("n", "K", vim.lsp.buf.hover)
    map("n", "<leader>lf", vim.lsp.buf.format)

    map("n", "<leader>gd", function()
      require("mini.extra").pickers.lsp({ scope = "definition" })
    end)

    map("n", "<leader>gD", function()
      require("mini.extra").pickers.lsp({ scope = "declaration" })
    end)

    map("n", "<leader>gs", function()
      require("mini.extra").pickers.lsp({ scope = "document_symbol"})
    end)

    map("n", "<leader>gi", function()
      require("mini.extra").pickers.lsp({ scope = "implementation" })
    end)

    map("n", "<leader>gr", function()
      require("mini.extra").pickers.lsp({ scope = "references" })
    end)

    map("n", "<leader>gt", function()
      require("mini.extra").pickers.lsp({ scope = "type_definition" })
    end)
  end,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config["lua_ls"] = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
      telemetry = {
        enable = false
      },
    },
  },
}

vim.lsp.config["bashls"] = {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git" },
  capabilities = capabilities,
}

vim.lsp.config["clangd"] = {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  root_markers = {
    "compile_commands.json",
    ".clangd",
    ".git",
  },
  capabilities = capabilities,
}

vim.lsp.config["basedpyright"] = {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "pyrightconfig.json",
    ".git",
  },
  capabilities = capabilities,
}

vim.lsp.config["nixd"] = {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = {
    "flake.nix",
    ".git",
  },
  capabilities = capabilities,
}

vim.lsp.enable({
  "lua_ls",
  "bashls",
  "clangd",
  "basedpyright",
  "nixd"
})
