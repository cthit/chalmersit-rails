FILE=database.lock
rails db:migrate
if [ ! -f "$FILE" ]; then
  rails db:seed
  touch "$FILE"
fi
rails s -p 3001 -b '0.0.0.0'
