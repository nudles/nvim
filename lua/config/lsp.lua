require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "lua-language-server", "pyright" },
})

local lspconfig = require("lspconfig")

lspconfig.clangd.setup({
  cmd = { "clangd", 
    "--background-index",        -- Enable background indexing
    "--clang-tidy=false",        -- Disable extra linting (makes it faster)
    "--completion-style=detailed", -- Use detailed autocompletion
    "--cross-file-rename",       -- Enable renaming across files
    "--limit-results=100",       -- Limit number of results for completion
    "--header-insertion=never",  -- Don't auto-add headers (reduces disk I/O)
    "--pch-storage=memory",      -- Store precompiled headers in memory
  },
  filetypes = { "c", "cpp", },
  root_dir = lspconfig.util.root_pattern("compile_commands.json", ".git"),
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})



