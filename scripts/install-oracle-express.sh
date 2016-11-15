#/bin/bash
#based on http://www.creative-doing.de/category/oracle-database/article/install-oracle-11gr2-express-edition-ubuntu-1404-64-bit
cd /tmp

# install ojdbc6.jar
wget https://files.jabref.org/test/ojdbc6.jar.enc
openssl aes-256-cbc -K $encrypted_2ff94d367f50_key -iv $encrypted_2ff94d367f50_iv -in ojdbc6.jar.enc -out ojdbc6.jar -d
cp ojdbc6.jar /home/travis/JabRef/jabref/lib
rm -rf /home/travis/JabRef/jabref/src/main/oracleMock
mkdir /home/travis/JabRef/jabref/src/main/oracleMock

# install oracle XE

cat <<EOF | sudo tee /sbin/chkconfig > /dev/null
#!/bin/bash
# Oracle 11gR2 XE installer chkconfig hack for Ubuntu
file=/etc/init.d/oracle-xe
if [[ ! `tail -n1 $file | grep INIT` ]]; then
echo >> $file
echo '### BEGIN INIT INFO' >> $file
echo '# Provides: OracleXE' >> $file
echo '# Required-Start: $remote_fs $syslog' >> $file
echo '# Required-Stop: $remote_fs $syslog' >> $file
echo '# Default-Start: 2 3 4 5' >> $file
echo '# Default-Stop: 0 1 6' >> $file
echo '# Short-Description: Oracle 11g Express Edition' >> $file
echo '### END INIT INFO' >> $file
fi
update-rc.d oracle-xe defaults 80 01
EOF
sudo chmod 755 /sbin/chkconfig

cat <<EOF | sudo tee /etc/sysctl.d/60-oracle.conf > /dev/null
# Oracle 11g XE kernel parameters
fs.file-max=6815744
net.ipv4.ip_local_port_range=9000 65000
kernel.sem=250 32000 100 128
kernel.shmmax=536870912
EOF

sudo service procps start
sudo ln -s /usr/bin/awk /bin/awk
sudo rm -rf /dev/shm
sudo mkdir /dev/shm
sudo mount -t tmpfs shmfs -o size=2048m /dev/shm

cat <<EOF | sudo tee /etc/rc2.d/S10oracle-mount > /dev/null
#! /bin/sh
### BEGIN INIT INFO
# Provides:          Creates Oracle mount point
# Required-Start:    
# Required-Stop:     
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Used for Oracle installation
# Description:       Used for Oracle installation
### END INIT INFO

# Aktionen
case "$1" in
    start)
        mkdir /var/lock/subsys 2>/dev/null
        touch /var/lock/subsys/listener
        rm /dev/shm 2>/dev/null
        mkdir /dev/shm 2>/dev/null
        mount -t tmpfs shmfs -o size=2048m /dev/shm
        ;;
    stop)
        ;;
    restart)
        ;;
esac
exit 0
EOF
sudo chmod 755 /etc/rc2.d/S10oracle-mount

sudo mkdir /var/lock/subsys
sudo touch /var/lock/subsys/listener

wget https://files.jabref.org/test/oracle-xe_11.2.0-2_amd64.deb.enc
 openssl aes-256-cbc -K $encrypted_2ff94d367f50_key -iv $encrypted_2ff94d367f50_iv -in oracle-xe_11.2.0-2_amd64.deb.enc -out oracle-xe_11.2.0-2_amd64.deb -d
sudo dpkg -i oracle-xe_11.2.0-2_amd64.deb
sudo /etc/init.d/oracle-xe start
