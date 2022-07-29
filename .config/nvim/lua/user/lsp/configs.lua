local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

-- On NixOS, sumneko must be installed as a nix package (sumneko-lua-language-server), the version installed by lsp-installer is not executable
-- local servers = { "intelephense", "phpactor", "jsonls", "sumneko_lua" }
local servers = { "intelephense", "jsonls", "sumneko_lua" }
-- local servers = { "phpactor", "jsonls", "sumneko_lua" }
-- phpactor + intelephense : conflit sur la gestion du 'gd' (go to definition)
-- phpactor : pas de détection des erreurs php (seulement autres avertissements)
-- intelephense : pas de gestion du refactoring

mason_lspconfig.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
