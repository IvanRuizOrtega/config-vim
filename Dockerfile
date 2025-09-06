FROM archlinux:latest

# Evitar prompts interactivos
ENV TERM xterm-256color

# Instalar dependencias
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    neovim git curl wget unzip nodejs npm python python-pip \
    php composer fzf ripgrep the_silver_searcher \
    bash-completion && \
    pacman -Scc --noconfirm

# -----------------------------
# Debuggers externos
# -----------------------------
# Python (debugpy para nvim-dap)
RUN pacman -S --noconfirm python-debugpy
# Node.js (debug adapter basado en vscode-node-debug2)
RUN npm install -g node-debug2
# PHP (Xdebug en Arch)
RUN pacman -S --noconfirm xdebug && \
    echo "zend_extension=xdebug.so" > /etc/php/conf.d/xdebug.ini && \
    echo "xdebug.mode=debug" >> /etc/php/conf.d/xdebug.ini && \
    echo "xdebug.start_with_request=yes" >> /etc/php/conf.d/xdebug.ini

# -----------------------------
# Configuración de shell
# -----------------------------
# Configurar aliases y prompt
RUN echo 'PS1="[\u@\h \W]\\$ "' >> /root/.bashrc && \
    echo "alias vi='nvim'" >> /root/.bashrc && \
    echo "alias vim='nvim'" >> /root/.bashrc && \
    echo "alias ll='ls -la --color=auto'" >> /root/.bashrc && \
    echo "alias g='git'" >> /root/.bashrc && \
    echo "alias d='docker'" >> /root/.bashrc

# Instalar vim-plug para Neovim
RUN curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copiar configuración de Neovim
COPY init.vim /root/.config/nvim/init.vim
COPY setup_vim.sh /root/setup_vim.sh

# Ejecutar setup
RUN chmod +x /root/setup_vim.sh && /root/setup_vim.sh

WORKDIR /root
CMD ["nvim"]
