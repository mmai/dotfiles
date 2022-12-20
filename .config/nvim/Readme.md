# NVV

Mise à jour plugins, syntaxe, serveurs lsp :

    :PackerUpdate 
    :TSUpdate
    :Mason (puis `u` sur un serveur pour le mettre à jour)

## Markdown


## Language server protocol

Installer des serveurs : `:Mason` (puis `u` sur un serveur pour le mettre à jour)

détail d'erreurs `gl`

### Todo

* zotero with jalvesaq/zotcite

## Troubleshooting

Erreur Treesitter à l'ouverture d'un fichier : essayer de désinstaller et réinstaller la lib pour le langage concerné : `:TSUninstall nix` (un `:TSUpdate` ne suffit pas)
