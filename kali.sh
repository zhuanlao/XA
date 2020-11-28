#!/bin/bash

echo ""
echo "=========================================================================="
echo "=               Kali Auto Init Tool                                      ="
echo "=                      Powered by ssooking                               ="
echo "=                      https://ssooking.github.io                        ="
echo "=========================================================================="

echo ""
echo "[*] 即将自动对kali进行基本配置，建议你根据需要修改脚本。安装配置过程可能需要一会儿，并且由你的网速决定...."
read -p "[*] 请按任意键继续...."


echo "[+] 添加kali源"
apt-key adv --recv ED444FF07D8D0BF6
echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list
echo "deb http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list
echo "deb http://mirrors.aliyun.com/debian stable main contrib non-free"  >> /etc/apt/sources.list
echo "[ok] 添加kali源成功！"
echo ""

echo "[+] 添加一个普通用户"
read -p "请输入用户名: " username
useradd -m -G sudo,video,audio,cdrom -s /bin/bash $username
echo "请设置用户密码："
passwd $username
echo "[ok] 添加普通用户成功！"
echo ""

# 安装内核头文件
echo "[+] 安装内核头文件... "
apt-get -y install linux-headers-$(uname -r)
echo ""
echo "[ok] 内核头文件安装成功！"
echo ""

# 解决kali启动时静音问题
echo "[+] 安装 alsa-utils 解决kali启动时静音问题"
apt-get -y install alsa-utils
echo "[ok] 安装 alsa-utils 成功！"
echo ""

echo "[+] 添加PPPoE拨号连接功能"
apt-get install pppoe pppoeconf
echo "[ok] 安装PPPoE成功!"
echo "      >> 你可以使用 nm-connection-editor 命令管理pppoe连接"
echo ""

echo "[+] 添加V**支持: PPTP IPsec/IKEv2 V**c network-manager-ssh"
apt-get -y install network-manager-pptp network-manager-pptp-gnome network-manager-strongswan network-manager-V**c network-manager-V**c-gnome network-manager-ssh
echo "[ok] 成功添加V**支持!"
echo ""


# Base Tool
echo "[+] 安装一些必备系统工具：谷歌拼音输入法、垃圾清理工具、截图工具、快速启动工具、软件包管理工具等"
apt-get -y install  fcitx fcitx-googlepinyin flameshot bleachbit gdebi synaptic synapse catfish scrot vokoscreen chromium
echo "[ok] 成功安装系统必备软件!"
echo ""

# Server Tools
echo "[+] 安装服务器连接管理工具：remmina、filezilla"
apt-get -y install remmina filezilla
echo "[ok] 安装服务器连接管理工具成功!"
echo ""

# 美化
echo "[+] 设置窗口按钮到左侧"
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,maximize,minimize:'
echo "[ok] 设置窗口按钮到左侧成功！"
echo ""

echo "[+] 安装中文字体"
apt-get -y install fonts-wqy-microhei fonts-wqy-zenhei
echo "[ok] 安装中文字体成功！"
echo ""

echo "[+] 安装基本美化工具"
apt-get -y install zsh screenfetch neofetch figlet peek
#apt-get -y install cairo-dock
echo "[ok] 安装成功！"
echo ""

echo "[+] 删除无用主题"
cd /usr/share/themes/ && rm -rf Albatross Blackbird Bluebird HighContrast Greybird*
echo "[ok] 删除成功！"

# Security Tools
echo "[+] 安装图形化十六进制编辑器bless"
apt-get -y install bless
echo "[ok] 安装成功！"
echo ""

echo "[+] 安装firewalld防火墙及iptables图形化管理工具gufw "
apt-get -y install gufw firewalld firewall-applet
#systemctl enable firewalld.service
echo "[ok] 安装成功！"
echo ""

# Install sublime text 3
echo "[+] 安装sublime text 3，速度可能会比较慢"
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt-get update
apt-get install sublime-text

echo "[+] 解决sublime-text 中文输入问题"
git clone https://github.com/lyfeyaj/sublime-text-imfix.git
cd sublime-text-imfix
cp ./lib/libsublime-imfix.so /opt/sublime_text/ && cp ./src/subl /usr/bin/
echo "[ok] 修复成功。输入subl命令启动sublime text即可输入中文！"
echo ""

# Install typora
echo "[+] 安装 typora，速度可能会比较慢"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
echo "deb http://typora.io linux/" | sudo tee /etc/apt/sources.list.d/typora.list
sudo apt-get update -y
sudo apt-get install typora
echo ""


echo "[+] 安装 node npm"
wget https://npm.taobao.org/mirrors/node/v8.9.3/node-v8.9.3.tar.gz
tar zxvf node-v8.9.3.tar.gz && mv node-v8.9.3-linux-x64 /opt
ln -s /opt/node-v8.9.3-linux-x64/bin/node /usr/local/bin/node
ln -s /opt/node-v8.9.3-linux-x64/bin/npm /usr/local/bin/npm
rm ~/node-v8.9.3.tar.gz
echo ""

echo "[+] 清除垃圾 ......"
apt-get clean && apt-get autoclean &&  apt-get autoremove -y　
echo "[+] Cleaning OK!"

# Install oh-my-zsh
# 普通用户就以普通权限安装
apt-get install zsh
echo "[+] Install oh-my-zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo " Setting oh-my-zsh be the default terminal"
chsh -s /bin/zsh
echo ""

neofetch
echo "[OK] 所有任务完成!"
