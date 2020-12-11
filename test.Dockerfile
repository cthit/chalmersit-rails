FROM ruby:2.5.1

#installs basic needed utils

RUN apt-get update && apt-get install -y \
net-tools apt-transport-https cmake libv8-dev nodejs

RUN mkdir /app
WORKDIR /app
COPY Gemfile* /app/

RUN bundle install --without guard --deployment

COPY . /app

ENV DATABASE_NAME it_test
ENV DATABASE_HOST db
ENV DATABASE_USER it
ENV DATABASE_PASSWORD iamapassword
ENV DATABASE_ADAPTER mysql2

CMD ["sh", "start_test.sh"]
