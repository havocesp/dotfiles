echo 'deb https://dl.bintray.com/myhush/hush/ hush main' | sudo tee --append /etc/apt/sources.list.d/hush.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61
sudo apt-get update
sudo apt-get install hush

mkdir -p ~/.hush
echo "rpcuser=username" >> ~/.hush/hush.conf
echo "rpcpassword=`head -c 32 /dev/urandom | base64`" >>~/.hush/hush.conf
echo "addnode=node.myhush.network" >> ~/.hush/hush.conf
echo "addnode=mmc01.madbuda.me" >> ~/.hush/hush.conf
echo "addnode=zdash.suprnova.cc" >> ~/.hush/hush.conf

hush-fetch-params

hushd --daemon
