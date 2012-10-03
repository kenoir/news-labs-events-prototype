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

Using autotest to run everything all the time:

    export AUTOFEATURE=true
    autotest

Rake tasks for everything else:

    rake default     # Default: run cukes  & specs.
    rake features    # Run Cucumber features
    rake jasmine     # Run JS specs via server
    rake jasmine:ci  # Run JS specs in continuous integration mode
    rake mockapi     # Start REST-Assured (Mock API)
    rake spec        # Run specs

Working with Github
-------------------

*Install [hub](http://defunkt.io/hub/)!*

### Working on a feature ###

 1. Create an issue describing the change
 2. Create a feature branch
 3. Write some code
 4. Make a pull request

    Associate pull requests with issues like so:

        hub pull-request -i $ISSUE_NUMBER -b BBC-Knowlearn:master -h BBC-Knowlearn:$NAME_OF_YOUR_FEATURE_BRANCH
    
 5. Assign a colleague to check the pull request.

### Closing a pull request ###

 1. Check for a green build on Travis
 2. Make sure everything looks ok
 3. Close the pull request

Deploying to Heroku
-------------------

Deploying from master:

    git push heroku master
    
Deploying from any other branch:

    git push heroku other_branch:master
    
More info: [https://devcenter.heroku.com/articles/git#deploying_code](https://devcenter.heroku.com/articles/git#deploying_code)
