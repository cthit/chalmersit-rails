FROM ruby:2.5.1

#installs basic needed utils

RUN apt-get update && apt-get install -y \
net-tools apt-transport-https cmake

# installs yarn which is needed to precompile
ENV PATH=/root/.yarn/bin:$PATH
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y \
yarn
#Packages

RUN apt-get clean

#Install gems
RUN mkdir /app
WORKDIR /app
COPY Gemfile* /app/
RUN bundle install

#Upload source
COPY . /app
RUN useradd ruby
RUN chown -R ruby /app
# Needed for yarn to work
RUN mkdir /home/ruby
RUN chown -R ruby /home/ruby

USER ruby


# Database defaults Replace these in Rancher.
ENV DATABASE_NAME name
ENV DATABASE_HOST db
ENV DATABASE_USER user
ENV DATABASE_PASSWORD pass
ENV DATABASE_ADAPTER mysql2

ENV OAUTH_ID oauth_id
ENV OAUTH_SECRET oauth_secret
ENV CLIENT_CREDENTIALS oauth_client_credentials


# Start server
ENV RAILS_ENV production
ENV RACK_ENV production
ENV SECRET_KEY_BASE secret
ENV PORT 3000
EXPOSE 3000

RUN rails assets:precompile

CMD ["sh", "start.sh"]
