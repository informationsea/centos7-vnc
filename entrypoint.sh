#!/bin/bash

if [ ! -f /home/.created ];then
    if [ -e $USER ];then
        export USER=user
    fi
    echo "    User: $USER"
    if [ -e $PASSWORD ];then
        export PASSWORD=user
        echo "Password: $PASSWORD"
    fi
    
    useradd -m $USER
    echo "$USER:$PASSWORD"|chpasswd
    gpasswd -a $USER wheel

    cat <<EOF > /home/$USER/.Xclients
ibus-daemon -drx
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
exec xfce4-session
EOF
    chmod +x /home/$USER/.Xclients
fi

cat <<EOF > /etc/supervisord.d/xrdp.ini
[program:turbovnc]
command=sudo -u $USER /opt/TurboVNC/bin/vncserver -fg -securitytypes TLSNone,None :1
redirect_stderr=true
autorestart=true
stdout_logfile=/var/log/vnc.log
EOF


if [ -e "$1" ];then
    exec "$@"
else
    exec /usr/bin/supervisord -n -c /etc/supervisord.conf
fi

