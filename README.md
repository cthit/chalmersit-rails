# Chalmers.it - Rails [![Build Status](https://travis-ci.org/cthit/chalmersit-rails.svg?branch=develop)](https://travis-ci.org/cthit/chalmersit-rails)

Currently using Ruby `2.4.0`

# Setup instructions

```
You may do the following in a vagrant/docker machine

# Install dependencies
Install the following: Ruby, mysql, nodejs, rbenv(with ruby-build package if needed), cmake, phantomjs(for the student union card balance)
(Also maybe: libcurl3 libcurl3-gnutls libcurl4-openssl-dev libmysqlclient-dev mysql-server redis-server)
Also, remember to install the right ruby version using rbenv.

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
Talk to digIT to gain access to the keys needed for development, the keys available are listed in digIT's Wiki
Paste the tokens into the launch.sh file
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

# Test mail functionality with mailcatcher:

(mailcatcher.me) Start with "mailcatcher --ip=0.0.0.0" if you want to run on your webbrowser. Check Vagrant file for portforwarding.

# Docker development setup

```bash
cp config/secrets.example.yml config/secrets.yml
docker-compose up

# run in another terminal window:
docker-compose run web rake db:setup

# => Server is now live at localhost:3000
```
