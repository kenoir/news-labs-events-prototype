BBC News Labs Events Prototype - Background Story
=================================================

An example event [http://news-labs-events-prototype.herokuapp.com/event/29](http://news-labs-events-prototype.herokuapp.com/event/29)

View [current features](https://www.relishapp.com/bbc-knowlearn/news-labs-events-prototype/docs)

[![Build Status](https://secure.travis-ci.org/BBC-Knowlearn/news-labs-events-prototype.png?branch=master)](http://travis-ci.org/BBC-Knowlearn/news-labs-events-prototype)

Setup
-----

You'll need:
 - [RVM](https://rvm.io/)
 - [Heroku Toolbelt](https://toolbelt.heroku.com/) or just the [foreman gem](https://github.com/ddollar/foreman)

In the project directory:

    gem install bundler
    bundle install
    
    bundle exec rake mockapi
    foreman start

Running tests
-------------

Using autotest to run everything:

    export AUTOFEATURE=true
    autotest

Rake tasks for everything else:

    rake default     # Default: run cukes  & specs.
    rake features    # Run Cucumber features
    rake jasmine     # Run JS specs via server
    rake jasmine:ci  # Run JS specs in continuous integration mode
    rake mockapi     # Start REST-Assured (Mock API)
    rake spec        # Run specs
