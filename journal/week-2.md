# Terraform Beginner Bootcamp 2023 - Week 2

### Table of Contents



## Working With Ruby

### Bundler

Bundler is a package manager for ruby. It is the primary way to install ruby packages (known as gems) for ruby.

### Install Gems

You need to create a "GemFile" and define your gems in that file

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the ``bundle install`` command.

This will install the fems in the system globally (unlike nodejs which installs packages in place in a folder called ```node_modules```).

A Gemfile.lock will be created to lock down the gem versions being used in this project.

### Executing Ruby Scripts In The Context of Bundler

We have to use ```bundle exec``` to tell future Ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

It's great for mock or dev servers, or for very simple projects. You can create a web-server in a single file.

https://sinatrarb.com

## Terratowns Mock Server

### Running The Web Server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the ``server.rb`` file.