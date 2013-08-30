#!/bin/sh

# Edit /etc/sshd.config and set :
# SyslogFacility local5
# LogLevel INFO

# Edit /etc/rsyslog.conf and add :
# local5.*     |/home/ppai/.sshdmonitor.pipe

# Restart sshd and rsyslog
# Install notify-send


P=/home/ppai/.sshmonitor.pipe
IP='[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'

test -p $P
if [ $? -ne 0 ]; then
        exit 1
fi

function parse_log_entry()
{
        res=$( echo "$1" | awk -F']: ' '{print $2}' )
        ip=$(echo "$res" | grep -o $IP)
        user=$(echo "$res" | grep -o "for .* from" | cut -d' ' -f2 )
        notice=""
        if [[ $res == Failed* ]]; then
                notice="$ip attempted to login as $user and failed"
        elif [[ $res == Accepted* ]]; then
                notice="$ip logged in as $user"
        elif [[ $res == Received* ]]; then
                notice="$ip disconnected"
        fi
        if [ -n "$notice" ];then
                notify-send -t 1000 "ssh" "$notice"
        fi
}

while read x <$P; do
        parse_log_entry "$x"
done
