# Chalmers.it - Rails [![Build Status](https://travis-ci.org/cthit/chalmersit-rails.svg?branch=develop)](https://travis-ci.org/cthit/chalmersit-rails)

Currently using Ruby `2.1.2p95`

```
# Install vagrant plugins
vagrant plugin install vagrant-vbguest vagrant-librarian-chef

# Start the VM and ssh into it
vagrant up
vagrant ssh
echo "PATH=$PATH:/home/vagrant/.rbenv/versions/2.1.2/bin/" >> /home/vagrant/.bashrc

# Install dependencies
sudo apt-get install libcurl3 libcurl3-gnutls libcurl4-openssl-dev libmysqlclient-dev mysql-server redis-server

cd /vagrant
gem install bundler
rbenv rehash
bundle install

# Create the secrets.yml file (fetch from wiki)
touch config/secrets.yml

# Add keys needed for auth
You need to be connected to the digIT network for these steps.
Go to korriban.chalmers.it, login using your standard account and then go to
korriban.chalmers.it/oauth/applications
Add a new application:
http://10.0.0.XXX:3000/auth/account/callback
Where XXX is your assigned IP when connected to the digIT network
Paste the generated tokens into the launch.sh file
Export variables to shell (export OAUTH_ID=XXX, export OAUTH_SECRET=YYY)
rake cthit:generate_token
Copy the generated token into client_credentials at secrets.yml

# Prepare the db
rake db:setup
rake rails:update:bin
rbenv rehash

# Start server:
Start the server by running the completed launch script.

# To connect to the server simply connect to your ip address on port 3000
```
