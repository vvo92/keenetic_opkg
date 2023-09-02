# Набор скриптов для выборочного роутинга через Warp от Cloudflare на Keenos 4.x.x

На основе прочтения темы на [ФОРУМЕ](https://forum.keenetic.com/topic/8106-%D0%B2%D1%8B%D0%B1%D0%BE%D1%80%D0%BE%D1%87%D0%BD%D1%8B%D0%B9-%D1%80%D0%BE%D1%83%D1%82%D0%B8%D0%BD%D0%B3-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-vpn-%D1%82%D1%83%D0%BD%D0%BD%D0%B5%D0%BB%D1%8C/):


Ставим утилиту dig и cron:

`opkg install bind-dig cron`

Делаем скрипты исполняемыми:

`chmod +x /opt/bin/unblock_vpn.sh`
`chmod +x /opt/etc/ndm/ifstatechanged.d/100-add_unblock_route.sh`

Делаем ссылку в крон:

`ln -s /opt/bin/unblock_vpn.sh /opt/etc/cron.daily/01unblock`

**nwg1** - имя интерфейса Wireguard\ 

Делаем бекап нужных файлов:
`tar -cvf /opt/tmp/unblock_backup.tar /opt/bin/unblock_vpn.sh /opt/etc/cron.daily/01unblock /opt/etc/ndm/ifstatechanged.d/100-add_unblock_route.sh /opt/etc/unblock-vpn.txt`