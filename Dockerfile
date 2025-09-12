FROM archlinux:latest

# Evitar prompts interactivos
ENV TERM xterm-256color

# -------------------------
# Base system
# -------------------------
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    neovim git curl wget unzip tar \
    nodejs npm yarn \
    python python-pip python-pynvim \
    php composer \
    fzf ripgrep the_silver_searcher \
    bash-completion make gcc \
    xclip \
    && pacman -Scc --noconfirm

# -------------------------
# Node.js providers & LSP
# -------------------------
RUN npm install -g \
    neovim \
    pyright \ 
    prettier \
    eslint \
    typescript \
    typescript-language-server \
    vscode-langservers-extracted \
    yaml-language-server

# -------------------------
# Python formatters & debug
# -------------------------
RUN pacman -S --noconfirm python-black python-debugpy && \
    pip install --no-cache-dir --break-system-packages autopep8

# -------------------------
# PHP tools
# -------------------------
RUN curl -L https://cs.symfony.com/download/php-cs-fixer-v3.phar -o /usr/local/bin/php-cs-fixer \
    && chmod +x /usr/local/bin/php-cs-fixer

# Xdebug para debugging en PHP
RUN pacman -S --noconfirm xdebug && \
    echo "zend_extension=xdebug.so" > /etc/php/conf.d/xdebug.ini && \
    echo "xdebug.mode=debug" >> /etc/php/conf.d/xdebug.ini && \
    echo "xdebug.start_with_request=yes" >> /etc/php/conf.d/xdebug.ini

# -----------------------------
# Node.js Debug adapter
# -----------------------------
RUN npm install -g node-debug2

# -----------------------------
# Shell config (aliases & prompt)
# -----------------------------
RUN echo 'PS1="[\u@\h \W]\\$ "' >> /root/.bashrc && \
    echo "alias vi='nvim'" >> /root/.bashrc && \
    echo "alias vim='nvim'" >> /root/.bashrc && \
    echo "alias ll='ls -la --color=auto'" >> /root/.bashrc && \
    echo "alias g='git'" >> /root/.bashrc && \
    echo "alias d='docker'" >> /root/.bashrc

# -----------------------------
# Neovim setup
# -----------------------------
# Instalar vim-plug (gestor de plugins)
RUN curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copiar configuración personalizada
COPY init.vim /root/.config/nvim/init.vim
COPY setup_vim.sh /root/setup_vim.sh

RUN chmod +x /root/setup_vim.sh && /root/setup_vim.sh

# -----------------------------
# Cleanup
# -----------------------------
RUN rm -rf /var/cache/pacman/pkg/* /tmp/*

WORKDIR /root
CMD ["nvim"]
