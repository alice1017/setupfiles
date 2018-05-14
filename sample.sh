#!/bin/sh
# coding: utf-8

# *********** WARNINGS **********
# This script assumes
#        ubuntu as an environment
# *******************************

PACKAGE_INSTALLER="apt-get install -y"
DOWNLOADER="wget -q --no-check-certificate"
GIT_CLONE="git clone -q"

# ======================
#  Update Docker Engine
# ======================

sudo $PACKAGE_INSTALLER apt-transport-https ca-certificates
sudo apt-key adv \
	--keyserver hkp://ha.pool.sks-keyservers.net:80 \
	--recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" \
    | sudo tee /etc/apt/sources.list.d/docker.list

sudo apt-get update
sudo apt-cache policy docker-engine
sudo $PACKAGE_INSTALLER docker-engine

# ======================
#   Install Packages
# ======================

#   - tools -
sudo $PACKAGE_INSTALLER zsh git vim w3m ctags make build-essential
#   - language -
sudo $PACKAGE_INSTALLER language-pack-ja language-pack-ja-base \
                                    manpages-ja manpages-ja-dev
#   - libraries -
sudo $PACKAGE_INSTALLER libssl-dev zlib1g-dev  xz-utils
sudo $PACKAGE_INSTALLER libbz2-dev libreadline-dev libsqlite3-dev
sudo $PACKAGE_INSTALLER llvm libncurses5-dev libncursesw5-dev
#  - servers -
sudo $PACKAGE_INSTALLER openssh-server mysql-server mysql-client

# ======================
#    download dotfile
# ======================

cd $HOME

#   - zshrc -
$DOWNLOADER -O .zshrc "https://raw.githubusercontent.com/alice1017/DockerFiles/master/zshrc"

#   - vim -
mkdir -p .vim/bundle
mkdir -p .vim/colors
$GIT_CLONE http://github.com/gmarik/vundle.git .vim/bundle/vundle

$DOWNLOADER -O .vim/vimrc \
    "https://gist.githubusercontent.com/alice1017/c66e2e07cb8cee95091b/raw/ed58259d8cd6e403ef9a9526bb190a413cf97018/vimrc"

ln -s .vim/vimrc .vimrc

$DOWNLOADER -O .vim/colors/solarized.vim \
    "https://raw.githubusercontent.com/altercation/vim-colors-solarized/master/colors/solarized.vim"

# ======================
#    Install Anyenv
# ======================

$GIT_CLONE https://github.com/riywo/anyenv .anyenv
echo '# anyenv setting\n' \
     'if [ -d $HOME/.anyenv ] ; then\n    ' \
     'export PATH="$HOME/.anyenv/bin:$PATH"\n    ' \
     'eval "$(anyenv init -)"\nfi\n' >> .zshrc

# ======================
#       Tear Down
# ======================

#  - change default shell -
sudo chsh -s /usr/bin/zsh vagrant

echo "Setup Comlete."

