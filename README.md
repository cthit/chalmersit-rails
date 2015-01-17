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
cd /vagrant
bundle install

# Create the secrets.yml file (fetch from wiki)
touch config/secrets.yml

# Prepare the db
rake db:create db:migrate
rake rails:update:bin
rbenv rehash

# Then serve:
rails server

# The instance is now accessible at localhost:3000
```
