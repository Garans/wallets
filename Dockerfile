FROM ruby:2.6.1

RUN apt-get update
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

RUN apt-get install -y --no-install-recommends \
               postgresql-client \
    && rm -rf /var/lib/apt/lists/*

ENV RAILS_ENV production
WORKDIR /usr/src/app
COPY . .
RUN gem install bundler && bundle install
EXPOSE 3000
CMD bash -c "bin/rails db:migrate && bin/rails crypted:db:migrate && bin/rails db:seed && bin/rails population:generate_wallet_list && bin/rails server"
