FROM ruby:2.5.9

RUN apt-get update && apt-get install -y \
  #Packages
  net-tools netcat build-essential libpq-dev nodejs cmake

RUN apt-get clean

RUN mkdir /app
WORKDIR /app
COPY Gemfile* /app/

RUN useradd -m ruby
RUN chown -R ruby /app

RUN bundle install

ENV DATABASE_NAME it_dev
ENV DATABASE_HOST db
ENV DATABASE_USER it
ENV DATABASE_PASSWORD iamapassword
ENV DATABASE_ADAPTER mysql2

ENV RAILS_ENV development
ENV RACK_ENV development
ENV PORT 3000
ENV RAILS_SERVE_STATIC_FILES true
ENV SECRET_KEY_BASE 7c86798726327eae7320ffd19ec935e51682e2e6750686cc631aba41f6e4f993719c28f3d35a9c88ac1f177ba7a58c61fa25a8beacfe22c233e339cde81ad63a
ENV OAUTH_SECRET secret
ENV OAUTH_ID id
ENV CLIENT_CREDENTIALS key
ENV ACCOUNT_ADDRESS http://localhost:8081/
EXPOSE 3000

COPY . /app

CMD ["sh", "start.sh"]
