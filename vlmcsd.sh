#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "错误，必须以root身份运行。"
    exit 1
fi

clear
printf "=======================================================================\n"
printf "Vlmcsd搭建KMS激活服务器一键脚本。 \n"
printf "=======================================================================\n"
printf "建议在debian8系统安装，centos注意开启1688端口。 \n"
printf "=======================================================================\n"

get_char()
{
    SAVEDSTTY=`stty -g`
    stty -echo
    stty cbreak
    dd if=/dev/tty bs=1 count=1 2> /dev/null
    stty -raw
    stty echo
    stty $SAVEDSTTY
}

if [ "$1" == "uninstall" ]; then
    echo ""
    echo "Press any key to start uninstall Vlmcsd..."
    char=`get_char`
    echo "Uninstall vlmcsd..."
    /etc/init.d/vlmcsd stop
    /sbin/chkconfig --del vlmcsd
    rm -f /etc/init.d/vlmcsd
    rm -f /usr/local/bin/vlmcsd-x64-musl-static
    echo "Uninstall Complete."
fi

if [ "$1" != "uninstall" ]; then
    echo ""
    echo "Press any key to start install Vlmcsd..."
    char=`get_char`

    if [ -s /etc/init.d/vlmcsd ]; then
        rm -f /etc/init.d/vlmcsd
    fi

    if [ -s /usr/local/bin/vlmcsd-x64-musl-static ]; then
        rm -f /usr/local/bin/vlmcsd-x64-musl-static
    fi

    echo "Install vlmcsd..."
    wget -c https://raw.githubusercontent.com/hongxiaoo/vlmcsd.sh/master/vlmcsd.server
    mv vlmcsd.server /etc/init.d/vlmcsd
    chmod 0755 /etc/init.d/vlmcsd

    wget https://github.com/hongxiaoo/vlmcsd/releases/download/svn1111/binaries.tar.gz
    tar -zxvf binaries.tar.gz 
    rm -f ./binaries.tar.gz
    cd ./binaries/Linux/intel/static/
    mv vlmcsd-x64-musl-static /usr/local/bin/vlmcsd-x64-musl-static
    chmod 0755 /usr/local/bin/vlmcsd-x64-musl-static

    /sbin/chkconfig --add vlmcsd

    echo "Install Complete."
    echo "Starting Vlmcsd..."
    /etc/init.d/vlmcsd start
fi
