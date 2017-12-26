# vlmcsd.sh
Vlmcsd搭建KMS激活服务器一键脚本

本脚本适用环境：

系统支持：CentOS
内存要求：≥32M
日期：2017 年 12 月 26 日

默认配置：
服务器端口：1688

使用方法：
使用root用户登录，运行以下命令：

wget -c http://mirrors.tintsoft.com/software/vlmcsd/vlmcsd.sh
chmod +x vlmcsd.sh
./vlmcsd.sh 2>&1 | tee vlmcsd.log
卸载方法：
使用 root 用户登录，运行以下命令：

./vlmcsd.sh uninstall
安装完成后即已后台启动 vlmcsd ，运行：

/etc/init.d/vlmcsd status
使用命令：
启动：/etc/init.d/vlmcsd start
停止：/etc/init.d/vlmcsd stop
重启：/etc/init.d/vlmcsd restart
状态：/etc/init.d/vlmcsd status

如果你的服务器开启了防火墙

请执行以下语句添加例外

/sbin/iptables -I INPUT -p tcp --dport 1688 -j ACCEPT
/sbin/iptables-save
