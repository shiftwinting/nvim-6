local lspconfig = require("lspconfig")
local format = require("config.lsp.format")

require("lsp_signature").on_attach({ hint_prfix = "﯑ " })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = {
      prefix = "",
    },
    update_in_insert = true,
  })

local sign_define = vim.fn.sign_define
sign_define("LspDiagnosticsSignError", { text = "", numhl = "RedSign" })
sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "YellowSign" })
sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "WhiteSign" })
sign_define("LspDiagnosticsSignHint", { text = "", numhl = "BlueSign" })

local enhance_attach = function(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    format.lsp_before_save()
  end
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
end

-- setup servers
local function setup_servers()
  require("lspinstall").setup()
  local servers = require("lspinstall").installed_servers()
  for _, server in pairs(servers) do
    require("lspconfig")[server].setup({ on_attach = enhance_attach })
  end
end

setup_servers()

require("lspinstall").post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end

-- python
lspconfig.pyright.setup({
  on_attach = enhance_attach,
  settings = {
    python = {
      analysis = {
        diagnosticMode = "workspace",
      },
    },
  },
})
