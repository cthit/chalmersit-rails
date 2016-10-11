# Chalmers.it - Rails [![Build Status](https://travis-ci.org/cthit/chalmersit-rails.svg?branch=develop)](https://travis-ci.org/cthit/chalmersit-rails)

Currently using Ruby `2.1.2p95`

# Setup instructions
```
You may do the following in a vagrant/docker machine

# Install dependencies
Install the following: Ruby, mysql, nodejs, rbenv
(Also maybe: libcurl3 libcurl3-gnutls libcurl4-openssl-dev libmysqlclient-dev mysql-server redis-server)


# Run:
rbenv rehash
bundle install

# Create the secrets.yml file (digIT might want to fetch from wiki instead)
cp config/secrets.yml.example config/secrets.yml
edit it so it looks like this:

development:
  secret_key_base: (AUTO GENERATED)
  client_credentials:

We will get the client_credentials later.

# Add keys needed for auth
You need to be connected to the digIT network for these steps (contact them if you need access).
Go to https://beta-account.chalmers.it, login using your standard account and then go to
https://beta-account.chalmers.it/oauth/applications
Add a new application:
http://0.0.0.0:3000/auth/account/callback
Paste the generated tokens into the launch.sh file
Export variables to shell (export OAUTH_ID=XXX, export OAUTH_SECRET=YYY)
rake cthit:generate_token
Copy the generated token into client_credentials at secrets.yml

# Prepare the db
rake db:setup
rake rails:update:bin
rbenv rehash

# Fix launch script
cp launch.sh.example launch.sh
Edit the script and insert your oauth id and secret from before.

# Start server:
Start the server by running the completed launch script.

# To connect to the server simply connect to your ip address on port 3000
```

# Old setup instructions
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
You need to be connected to the digIT network for these steps (contact them if you need access).
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

#Test mail functionality with mailcatcher:
(mailcatcher.me) Start with "mailcatcher --ip=0.0.0.0" if you want to run on your webbrowser. Check Vagrant file for portforwarding.
