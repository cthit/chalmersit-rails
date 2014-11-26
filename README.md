# Chalmers.it - Rails

Currently using Ruby `2.1.2p95`

```
# Install vagrant plugins
vagrant plugin install vagrant-vbguest vagrant-librarian-chef

# Start the VM and ssh into it
vagrant up
vagrant ssh

# Install dependencies
cd /vagrant
bundle install

# Prepare the db
rake db:create db:migrate
rake rails:update:bin

# Then serve:
rails server

# The instance is now accessible at localhost:3000
```
