FROM archlinux:latest

# Instalar Vim y dependencioas
RUN pacman -Sy --noconfirm vim git curl nodejs npm python-pip

# Instalar autopep8 globalmente con pip (Python)
RUN pip3 install --no-cache-dir autopep8 --break-system-packages

# Instalar Vim-Plug
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Descargar y copiar el archivo .vimrc desde GitHub
RUN curl -sSLo ~/.vimrc https://raw.githubusercontent.com/IvanRuizOrtega/config-vim/refs/heads/main/vimrc

# Ejecutar Vim-Plug y CocInstall en un script
COPY setup_vim.sh /setup_vim.sh
RUN chmod +x /setup_vim.sh && /setup_vim.sh

# Definir el directorio de trabajo por defecto
WORKDIR /projects

# Ejecutar bash por defecto
CMD ["/bin/bash"]
