sh wait_for_db.sh
RAILS_ENV=test bundle exec rake db:migrate db:seed --trace
RAILS_ENV=test bundle exec rspec
