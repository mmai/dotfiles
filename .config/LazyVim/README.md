# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## LSP & NixOS

Installés par NixOS car les versions téléchargées par Mason ne s'éxécutent pas :
- stylua, lua-language-server
- rust-analyser

## Tests avec Neotest

Les configurations rust (version rustaceansvim) et php sont incompatibles.

Pour la version rust commenter les lignes suivantes, les décommenter pour la version PHP
  - `opts = { adapters = { "neotest-phpunit" } },` du fichier lua/plugins/test.lua
  - { import = "lazyvim.plugins.extras.test.core" } du fichier lua/config/lazy.lua

## Howto

- afficher les messages d'alerte qui disparaissent : `<space>snh` (_noice_ history) ou `<space>snl` (_noice_ last message)

## Troubleshooting

error executing vim.schedule lua callback ... Treesitter/lua... no parser for php language

=> `:TSInstall php`
