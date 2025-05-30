FROM archlinux:latest

# Instalar Vim y dependencioas
RUN pacman -Sy --noconfirm vim git curl nodejs npm python python-pip php ripgrep

# Instala las herramientas de NodeJS globalmente en otro RUN para evitar fallos
RUN npm install -g \
    intelephense \
    typescript \
    typescript-language-server \
    yaml-language-server \
    eslint \
    prettier \
    pyright

# Instalar autopep8 globalmente con pip (Python)
RUN pip3 install --no-cache-dir autopep8 --break-system-packages

# Instalar Vim-Plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Descargar y copiar el archivo .vimrc desde GitHub
RUN curl -sSLo ~/.vimrc https://raw.githubusercontent.com/IvanRuizOrtega/config-vim/refs/heads/main/vimrc

## Themes use colorscheme clt + d
RUN  mkdir -p ~/.vim/colors && \ 
curl -sSLo ~/.vim/colors/gruvbox.vim https://raw.githubusercontent.com/morhetz/gruvbox/refs/heads/master/colors/gruvbox.vim

# Configurar CoC para que no falle la instalación
RUN mkdir -p ~/.config/coc/extensions && \
    cd ~/.config/coc/extensions && \
    npm install --global-style --ignore-scripts --no-bin-links --no-package-lock coc-prettier coc-pyright coc-tsserver coc-html coc-css coc-phpls coc-eslint coc-json

# Definir la variable de entorno de Node.js para CoC
ENV NODE_PATH=/root/.config/coc/extensions/node_modules

# Ejecutar Vim-Plug y CocInstall en un script
COPY setup_vim.sh /setup_vim.sh
RUN chmod +x /setup_vim.sh && /setup_vim.sh

# Antes de CMD o al final
RUN git config --global --add safe.directory /projects

# Definir el directorio de trabajo por defecto
WORKDIR /projects

# Ejecutar bash por defecto
CMD ["vim"]
