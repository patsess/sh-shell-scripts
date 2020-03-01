#!/bin/bash

echo "UNTESTED!! LIKELY WILL NEED FINE TUNING (DESIGNED FOR UBUNTU 18.04)"

sudo apt-get update
sudo apt-get install jq

# Redshift:
# https://www.maketecheasier.com/protect-eyes-redshift-linux/
sudo apt-get install redshift redshift-gtk

# Python3.8:
# https://linuxize.com/post/how-to-install-python-3-8-on-ubuntu-18-04/
# https://linuxize.com/post/how-to-install-pip-on-ubuntu-18.04/
sudo apt update
sudo apt install build-essential libssl-dev libffi-dev python3-dev
sudo apt install software-properties-common
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install python3.8
sudo apt install python3-pip
pip3 install virtualenv  # for virtual environments

# Chrome:
# https://linuxize.com/post/how-to-install-google-chrome-web-browser-on-ubuntu-18-04/
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb

# Git:
# https://linuxize.com/post/how-to-install-git-on-ubuntu-18-04/
sudo apt install git

# Texmaker:
# https://dzone.com/articles/installing-latex-ubuntu
sudo apt-get install texlive-full
sudo apt-get install texmaker

# Atom:
# https://codeforgeek.com/install-atom-editor-ubuntu-14-04/
sudo apt-get install atom
# note: installs to /usr/bin/ directory, such that the command /usr/bin/atom lauches Atom

# Julia:
# https://github.com/abelsiqueira/jill
bash -ci "$(curl -fsSL https://raw.githubusercontent.com/abelsiqueira/jill/master/jill.sh)"

# Postman:
# https://linuxize.com/post/how-to-install-postman-on-ubuntu-18-04/
sudo snap install postman

# PyCharm:
# https://linuxize.com/post/how-to-install-pycharm-on-ubuntu-18-04/
sudo snap install pycharm-community --classic

# Scala:
# https://blogs.ashrithgn.com/install-scala-and-scala-build-tools-ubuntu/
# http://www.codebind.com/linux-tutorials/install-scala-sbt-java-ubuntu-18-04-lts-linux/

# Installing scala build tool
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
sudo apt-get install sbt

# Installing Scala
sudo apt-get install scala
