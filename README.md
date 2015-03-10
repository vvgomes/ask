# Ask

Ask is a web application to help people to save, share, and like their favorite interview question. The application is currently intended to be used internally at [ThoughtWorks®][tw], so useres will have to authenticate using their Thoughtworks [Okta][okta] credentials.

![App Screenshot](http://bit.ly/1896btH)

## Stack

Ask is a very minimal [Ruby on Rails][rails] application. All depencies specified in the Gemfile). For data storage, it uses [PostgreSQL][postgresql] database in development & production environments and [Sqlite3][sqlite3] in test environment.

The official CI server is Snap. It runs the tests and deploys the app to Heroku. Here are the links:

* [CI](https://snap-ci.com/vvgomes/ask/branch/master)
* [Live app](https://askapp.herokuapp.com)

## Building

After cloning the repository, make sure you have the specified Ruby version & Bundler gem installed. Then run

```
$ bundle install
```

If everything goes well, make sure you have a PostgreSQL server running and then setup your database with:

```
$ rake db:create:all
$ rake db:migrate
```

Ensure you have all the tests passing:

```
$ rake
```

And, finally, run the rails server:

```
$ rails s -p 4567
```

Note that you need to specify the port because the server will try to connect with [Okta Sample App][okta-preview].

## Contributing

Feel free to fork the repository and submit pull-requests.

[tw]: (http://www.thoughtworks.com)
[screenshot]: (http://bit.ly/1896btH)
[rails]: (https://github.com/rails/rails)
[postgresql]: (http://postgresql.org)
[sqlite3]: (http://sqlite.org)
[heroku]: (http://heroku.com)
[snap]: (http://snap-ci.com)
[okta]: (https://thoughtworks.okta.com)
[okta-preview]: (https://thoughtworks.oktapreview.com/app/UserHome)