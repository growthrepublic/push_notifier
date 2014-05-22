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

### Usage

Application as is, has no authentication included, we use it internally,
disabling external connections with Nginx config.
You should pair your application users with User model in this application using
"shared_id" key. With this approach, you will get unique data for each of your user.

For now, API consists of three main endpoints:

  - POST "devices" - updates user devices list with a new device token,
  if user does not exist yet, it creates and initializes him with specified token,

  - DELETE "devices" - deletes device token from user devices list,

  - POST "notify" - sends message to user.

You can play with them by setting up this application and visiting "/swagger" path,
using your web browser.
