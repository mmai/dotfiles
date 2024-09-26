# 💤 LazyVim

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

## LSP & NixOS

Installés par NixOS car les versions téléchargées par Mason ne s'éxécutent pas :
- stylua, lua-language-server
- rust-analyser

## Howto

- Go to definition : gd
- Go to references : gr
- retourner sur emplacement précédent après gd ou gr : ctrl-o

- afficher les messages d'alerte qui disparaissent : `<space>snh` (_noice_ history) ou `<space>snl` (_noice_ last message)
- modifier le code d'un plugin : aller dans ~/.local/share/nvim/lazy/

## Troubleshooting

error executing vim.schedule lua callback ... Treesitter/lua... no parser for php language

=> `:TSInstall php`

Startup time

$ vim --startuptime vim.log

## Configurations & études

- [PHP](doc/PHP.md)
- [IA](doc/IA.md)
