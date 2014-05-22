Push Notifier [![Code Climate](https://codeclimate.com/github/growthrepublic/push_notifier.png)](https://codeclimate.com/github/growthrepublic/push_notifier) [![Build Status](https://travis-ci.org/growthrepublic/push_notifier.svg?branch=master)](https://travis-ci.org/growthrepublic/push_notifier)
========


### Ruby version

2.1.1

### Configuration

Install gems:

      $ bundle install

Copy config/mongoid.yml.example to config/mongoid.yml:

      $ cp config/mongoid.yml.example config/mongoid.yml

Then, edit config/mongoid.yml to set up database connection.

Create database:

      $ bundle exec rake db:create

### How to run the test suite

If it is your first time, running test suite for this app, run this to build db for test:

      $ bundle exec rake db:create RAILS_ENV=test

And then run rspec:

      $ bundle exec rspec
