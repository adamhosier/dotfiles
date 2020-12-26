#!/bin/bash

# Install tools.
apt -y update
apt -y install \
	curl \
	direnv \
	neovim \
	python3-pip \
	ripgrep \
	tmux \
	unzip \
	zsh

# Install prezto.
if [ ! -d "$HOME/.zprezto" ] ; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$HOME/.zprezto"
fi

# Install neovim Plug.
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ] ; then 
  curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Install neovim prereqs.
pip3 install --user pynvim --upgrade msgpack

# Copy zsh defaults.
zsh -c 'setopt EXTENDED_GLOB
for rcfile in "$HOME"/.zprezto/runcoms/^README.md(.N); do
  if [ ! -f "$HOME/.${rcfile:t}" ] ; then
    ln -s "$rcfile" "$HOME/.${rcfile:t}"
  fi 
done'

# Copy zsh overrides.
ln -sf "$HOME/dotfiles/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$HOME/dotfiles/zsh/.zpreztorc" "$HOME/.zpreztorc"

# Copy git overrides.
ln -sf "$HOME/dotfiles/git/.gitconfig" "$HOME/.gitconfig"

# Copy tmux overrides.
ln -sf "$HOME/dotfiles/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Copy neovim overrides.
mkdir -p "$HOME/.config/nvim/colors"
ln -sf "$HOME/dotfiles/nvim/init.vim" "$HOME/.config/nvim/init.vim"
ln -sf "$HOME/dotfiles/nvim/colors/smyck.vim" "$HOME/.config/nvim/colors/smyck.vim"

# Install neovim plugins.
nvim +PlugInstall +qall

# Change default shell.
sed s/required/sufficient/g -i /etc/pam.d/chsh
chsh -s /bin/zsh

# Generate SSH key.
if [ ! -f "$HOME/.ssh/id_rsa" ] ; then 
  ssh-keygen -t rsa -b 4096 -q -f "$HOME/.ssh/id_rsa" -N "" -C "hosieradam@gmail.com"
fi

# Configure remote of dotfiles to use ssh
pushd "$HOME/dotfiles"
git remote set-url origin git@github.com:adamhosier/dotfiles.git
popd

# Install & configure rust.
if [ -f "$HOME/.cargo/bin/rustup" ] ; then
  $HOME/.cargo/bin/rustup update
else 
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi
$HOME/.cargo/bin/rustup component add rls
