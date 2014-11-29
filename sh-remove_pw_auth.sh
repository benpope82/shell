ssh root@$1 <<'ENDSSH'
 sudo sed -E -i.bak 's/^#?(PasswordAuthentication|ChallengeResponseAuthentication).*$/\1 no/' /etc/ssh/sshd_config
 /etc/init.d/ssh restart
ENDSSH