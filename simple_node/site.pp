#!/bin/bash
chmod 0700 /root/.ssh/coms_rsa
echo $PUBLIC_KEY >> /home/centos/.ssh/authorized_keys
echo "$SERVER_IP consul0" | sudo tee --append /etc/hosts 2> /dev/null
echo "$OWN_IP $HOSTNAME" | sudo tee --append /etc/hosts 2> /dev/null
       
hostname $HOSTNAME
        
TMP_PATH=`mktemp -d`
mkdir -p /etc/puppet/hiera
git clone https://github.com/thbeh/puppetfiles.git $TMP_PATH

cp -R $TMP_PATH/puppet/* /etc/puppet/
cp -R $TMP_PATH/hiera/hiera.yaml /etc/puppet/
cp -R $TMP_PATH/hiera/* /etc/puppet/hiera/
        
echo "server_ip: \"$SERVER_IP\"" | sudo tee --append /etc/puppet/hiera/common.yaml 2> /dev/null

cat << EOF >> /etc/puppet/site.pp
class { 'jdk_oracle':
version => "7"
}       
EOF     

puppet apply /etc/puppet/site.pp
