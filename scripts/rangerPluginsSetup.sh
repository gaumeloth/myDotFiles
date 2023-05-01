#!/bin/sh

git clone https://github.com/cdump/ranger-devicons2 ~/.config/ranger/plugins/devicons2
echo "default_linemode devicons2" >> $HOME/.config/ranger/rc.conf


git clone https://github.com/yonghie/ranger-gitplug
cd ranger-gitplug
make install


