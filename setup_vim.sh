#!/bin/bash

# ============================
# Instalar plugins de Neovim con vim-plug
# ============================
nvim +'PlugInstall --sync' +qall

# ============================
# Instalar extensiones de coc.nvim (solo LSP/format, no debug)
# ============================
nvim +'CocInstall -sync coc-prettier coc-pyright coc-tsserver coc-html coc-css coc-phpls coc-eslint coc-json' +qall

# ============================
# Crear carpeta de configuración de CoC si no existe
# ============================
mkdir -p ~/.vim

# ============================
# Configuración de CoC
# ============================
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

# ============================
# Configuración de nvim-dap
# ============================
mkdir -p ~/.config/nvim/lua
mkdir -p ~/.local/share/nvim/dap_adapters

# Clonar adaptadores si no existen
if [ ! -d ~/.local/share/nvim/dap_adapters/vscode-php-debug ]; then
  git clone https://github.com/xdebug/vscode-php-debug ~/.local/share/nvim/dap_adapters/vscode-php-debug
  (cd ~/.local/share/nvim/dap_adapters/vscode-php-debug && npm install && npm run build)
fi

if [ ! -d ~/.local/share/nvim/dap_adapters/vscode-node-debug2 ]; then
  git clone https://github.com/microsoft/vscode-node-debug2 ~/.local/share/nvim/dap_adapters/vscode-node-debug2
  (cd ~/.local/share/nvim/dap_adapters/vscode-node-debug2 && npm install && npm run build)
fi

# ============================
# Configuración de DAP (Python, PHP, Node.js/TS)
# ============================
cat > ~/.config/nvim/lua/dap-config.lua <<'EOF'
local dap = require('dap')
local dapui = require('dapui')

-- UI + Virtual Text
dapui.setup()
require("nvim-dap-virtual-text").setup()

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

-- ========================
-- Python (debugpy attach)
-- ========================
dap.adapters.python = {
  type = 'server',
  host = "127.0.0.1",
  port = 5678, -- dummy, se sobrescribe en connect()
}
dap.configurations.python = {
  {
    type = 'python',
    request = 'attach',
    name = "Python: Attach (dynamic)",
    justMyCode = false,
    connect = function()
      return {
        host = vim.fn.input("Host [default: 127.0.0.1]: ", "127.0.0.1"),
        port = tonumber(vim.fn.input("Port [default: 5678]: ", "5678")),
      }
    end,
    pathMappings = {
      {
        localRoot = vim.fn.getcwd(),
        remoteRoot = "/app",
      },
    },
  },
}

-- ========================
-- PHP (Xdebug attach)
-- ========================
dap.adapters.php = {
  type = 'server',
  host = "127.0.0.1",
  port = 9003
}
dap.configurations.php = {
  {
    type = 'php',
    request = 'launch',
    name = "PHP: Xdebug (dynamic)",
    connect = function()
      return {
        host = vim.fn.input("Host [default: 127.0.0.1]: ", "127.0.0.1"),
        port = tonumber(vim.fn.input("Port [default: 9003]: ", "9003")),
      }
    end,
    pathMappings = {
      ["/var/www/html"] = vim.fn.getcwd()
    },
  },
}

-- ========================
-- Node.js / TypeScript (attach)
-- ========================
dap.adapters.node2 = {
  type = 'server',
  host = function()
    return vim.fn.input('Host [default: localhost]: ', '127.0.0.1')
  end,
  port = function()
    return tonumber(vim.fn.input('Port [default: 9229]: ', '9229'))
  end
}
dap.configurations.javascript = {
  {
    type = "node2",
    request = "attach",
    name = "Attach Node.js",
    restart = true,
  }
}
dap.configurations.typescript = {
  {
    type = "node2",
    request = "attach",
    name = "Attach Node.js (TS)",
    restart = true,
  }
}
EOF

# ============================
# Mensaje final
# ============================
echo "✅ Configuración completada."
echo "Agrega en tu init.vim o init.lua:"
echo "  lua require('dap-config')"
echo ""
echo "Requisitos adicionales:"
echo "  - Python: pip install debugpy"
echo "  - Node:   adaptador en ~/.local/share/nvim/dap_adapters/vscode-node-debug2"
echo "  - PHP:    habilitar Xdebug (puerto 9003) en tu contenedor"
