# OpenBSD Setup

cat >> ~/.profile <<EOF
PS1='(exit-code=$?)\n\n`whoami` @ `hostname -s` (`uname -s`) `pwd`\n$ '
EDITOR=vi
export PS1 EDITOR
alias pinst='pkg_add'
alias psearch='pkg_info -Q'
EOF

cp /etc/examples/doas.conf /etc
# Then add 'nopass' as argument to permit command in /etc/doas.conf

pkg_add icewm firefox vim roxterm git avahi

doas rcctl start messagebus
doas rcctl start avahi_daemon
doas rcctl start avahi_dnsconfd

doas rcctl enable messagebus
doas rcctl enable avahi_daemon
doas rcctl enable avahi_dnsconfd

cat > ~/.xsession <<EOF
# doas wsconsctl mouse.tp.tapping=1,3,2
xsetroot -mod 4 2 -fg SteelBlue
icewm
EOF

cat > /etc/hostname.run0 <<EOF
join Gungwald  wpakey password
inet autoconf
inet6 autoconf
EOF



