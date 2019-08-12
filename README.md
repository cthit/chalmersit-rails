# Chalmers.it - Rails [![Build Status](https://travis-ci.org/cthit/chalmersit-rails.svg?branch=develop)](https://travis-ci.org/cthit/chalmersit-rails)

Currently using Ruby `2.4.0`

## Setup instructions

You may do the following in a vagrant/docker machine

### Install dependencies
Install the following: `Ruby`, `gem` (may be installed with ruby automatically), `mysql` (google how to do this on your system, tends to vary a bit), `nodejs`, `rbenv` (on arch the `ruby-build` package from the aur is also required, not sure about ubuntu/macos), `cmake`
(Also maybe: `libcurl3` `libcurl3-gnutls` `libcurl4-openssl-dev` `redis-server`)

Install bundle with ruby `gem install bundler`.

### Install correct ruby version
```
rbenv install
rbenv rehash
```

### Install ruby dependencies
`bundle install`


### Create the secrets.yml file
`cp config/secrets.yml.example config/secrets.yml`

Edit it so it looks like this:
```
development:
  secret_key_base: (AUTO GENERATED)
```

### Prepare the db
```
rake db:setup
rake rails:update:bin
```

### Start server:
`bin/rails s`

May need to run `rbenv rehash` if you've been working on something using a different ruby version or have restarted your computer etc.

### Open site
Open `0.0.0.0:3000` in a browser.

## Test mail functionality with mailcatcher:
Start with `mailcatcher --ip=0.0.0.0` if you want to run on your webbrowser.

## For "logged in like behaviour":
Download and set up [https://github.com/lindskogen/chalmersit-account-mock](https://github.com/lindskogen/chalmersit-account-mock).

Start it in a docker container (or however you want to). In this project, change `config.account_ip` in `config/environments/development.rb` to `'http://localhost:6789'`.

You should now be able to log in to test admin/fkit functionality.

# Docker development setup

```bash
cp config/secrets.example.yml config/secrets.yml
docker-compose up

# run in another terminal window:
docker-compose run web rake db:setup

# => Server is now live at localhost:3000
```
