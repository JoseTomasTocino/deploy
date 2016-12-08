#!/bin/bash

# Añadir repositorios
read -p "¿Instalar synapse? (s/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]
then
    echo -e '\E[37;44m'"\033[1m# Añadiendo repositorio para synapse \033[0m"
    sudo add-apt-repository -y ppa:synapse-core/ppa
	sudo apt-get update
	sudo apt-get install -y synapse
fi

read -p "¿Instalar Sublime Text 3? (s/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]
then
    echo -e '\E[37;44m'"\033[1m# Añadiendo repositorio para Sublime Text \033[0m"
	sudo add-apt-repository -y ppa:webupd8team/sublime-text-3
	sudo apt-get update
	sudo apt-get install -y sublime-text-installer
fi    

read -p "¿Instalar JDownloader? (s/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]
then
    sudo add-apt-repository -y ppa:jd-team/jdownloader
    sudo apt-get update
    sudo apt-get install -y jdownloader
fi

read -p "¿Instalar Software básico? (s/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]
then
    # Instalación de software básico
    echo -e '\E[37;44m'"\033[1m# Instalando software básico \033[0m"
    sudo apt-get install -y terminator python-pip gparted \
	build-essential python-dev libxml2-dev libxslt1-dev zlib1g-dev \
	emacs imagemagick fabric git curl ipython ttf-mscorefonts-installer \
	ppa-purge ack-grep aptitude synaptic gdebi-core vlc xubuntu-restricted-extras
fi

read -p "¿Instalar Google Chrome? (s/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]
then
    # Instalación de Google Chrome
    echo -e '\E[37;44m'"\033[1m# Instalando Google Chrome\033[0m"
    sudo apt-get install -y libcurl3 libnspr4-0d libxss1
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome*; rm google-chrome*
fi

read -p "¿Instalar Virtualenv y VirtualenvWrapper? (s/n)" -n 1 -r
echo
if [[ $REPLY =~ ^[Ss]$ ]]
then
    # Instalación de virtualenv
    echo -e '\E[37;44m'"\033[1m# Instalando virtualenv \033[0m"
    sudo pip install virtualenv
    sudo pip install virtualenvwrapper
fi
