#!/bin/bash

# Instalar plugins de Vim
vim +'PlugInstall --sync' +qall

# Instalar CoC extensions
vim +'CocInstall coc-prettier coc-pyright coc-tsserver coc-html coc-css coc-phpls coc-eslint coc-json' +qall

# Crear carpeta de configuración de CoC si no existe
mkdir -p ~/.vim

# Escribir configuración de CoC
cat > ~/.vim/coc-settings.json <<EOF
{
  "coc.preferences.formatOnSave": true,
  "coc.preferences.formatOnType": true,
  "languageserver": {
    "python": {
      "command": "pyright-langserver",
      "args": ["--stdio"],
      "filetypes": ["python"]
    },
    "php": {
      "command": "intelephense",
      "filetypes": ["php"]
    },
    "json": {
      "command": "vscode-json-languageserver",
      "args": ["--stdio"],
      "filetypes": ["json"]
    },
    "javascript": {
      "command": "typescript-language-server",
      "args": ["--stdio"],
      "filetypes": ["javascript", "javascriptreact"]
    },
    "typescript": {
      "command": "typescript-language-server",
      "args": ["--stdio"],
      "filetypes": ["typescript", "typescriptreact"]
    },
    "html": {
      "command": "vscode-html-languageserver",
      "args": ["--stdio"],
      "filetypes": ["html"]
    },
    "css": {
      "command": "vscode-css-languageserver",
      "args": ["--stdio"],
      "filetypes": ["css", "scss", "less"]
    },
    "yaml": {
      "command": "yaml-language-server",
      "args": ["--stdio"],
      "filetypes": ["yaml"]
    }
  }
}
EOF

