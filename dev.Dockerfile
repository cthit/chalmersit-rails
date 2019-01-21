FROM ruby:2.4

RUN apt-get update && apt-get install -y \
#Packages
net-tools netcat build-essential libpq-dev nodejs cmake

RUN apt-get clean


RUN mkdir /app
WORKDIR /app
COPY Gemfile* /app/
#This is done to avoid installing at rebuild
RUN bundle install  

ENV DATABASE_NAME it_dev
ENV DATABASE_HOST db
ENV DATABASE_USER it
ENV DATABASE_PASSWORD iamapassword
ENV DATABASE_ADAPTER mysql2

ENV RAILS_ENV development
ENV RACK_ENV development
ENV SECRET_KEY_BASE secret
ENV PORT 3000
EXPOSE 3000

RUN useradd ruby

COPY . /app
RUN chown -R ruby /app
USER ruby


CMD ["sh", "start.sh"]