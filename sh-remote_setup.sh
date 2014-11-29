IP=$1
ssh root@$IP <<'ENDSSH'
 service apache2 stop
 update-rc.d -f apache2 remove
 service sendmail stop
 update-rc.d -f sendmail remove
 service xinetd stop
 update-rc.d -f xinetd remove
 service saslauthd stop
 update-rc.d -f saslauthd remove

 apt-get update
 apt-get install curl git-core
 curl http://nodejs.org/dist/v0.10.24/node-v0.10.24-linux-x86.tar.gz | tar -xz
 echo "PATH=$PATH:~/node-v0.10.24-linux-x86/bin;export PATH;" >> ~/.bashrc
 source ~/.bashrc
ENDSSH

cat ~/.ssh/id_dsa.pub | ssh root@$IP "mkdir ~/.ssh && cat - >> ~/.ssh/authorized_keys"

ssh root@$IP <<'ENDSSH'
 sudo sed -E -i.bak 's/^#?(PasswordAuthentication|ChallengeResponseAuthentication).*$/\1 no/' /etc/ssh/sshd_config
 /etc/init.d/ssh restart
ENDSSH