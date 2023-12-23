FROM ruby:3.0.3

#add yarn using curl
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

#install the required packages
RUN apt-get update -qq \
&& apt-get install -y \
apt-utils \
nodejs \
yarn \
nano

# Create directory docker-rails for project work directory
RUN mkdir /docker-rails

# Change directory to docker-rails
WORKDIR /docker-rails

#copy gemfile and gem.lock file to docker-rails
COPY Gemfile /docker-rails/Gemfile
COPY Gemfile.lock /docker-rails/Gemfile.lock

# Install gem dependencies
RUN bundle install

RUN bundle exec rails db:migrate

COPY . /docker-rails

EXPOSE 3000

# CMD ["rails", "server", "-b", "0.0.0.0"]

