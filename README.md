# Ask

Ask is a web application to help people saving, sharing, and liking their favorite interview questions. The application is currently intended to be used internally at [ThoughtWorks®](http://www.thoughtworks.com), so users are required to authenticate using their Thoughtworks credentials.

![App Screenshot](https://raw.githubusercontent.com/vvgomes/ask/master/doc/screenshot.png)

## Stack

Ask is a very minimal [Ruby on Rails](https://github.com/rails/rails) application. All depencies are specified in the Gemfile. For data storage it uses [PostgreSQL](http://postgresql.org) database in development & production environments and [Sqlite3](http://sqlite.org) in test environment.

There is a [Snap-CI](http://snap-ci.com) build which runs the tests and deploys the app to [Heroku](http://heroku.com). Here are the links:

* [CI](https://snap-ci.com/vvgomes/ask/branch/master)
* [Live app](https://askapp.herokuapp.com)

## Building

After cloning the repository, make sure you have the specified Ruby version & [Bundler](http://bundler.io) installed. Then run:

```
$ bundle install
```

If everything goes well, make sure you have a PostgreSQL server running and then setup the database with:

```
$ rake db:create:all
$ rake db:migrate
```

Ensure you have all the tests passing:

```
$ rake
```

Before running the server you will have to setup Google authentication. You'll need two environment vars: `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET`. Intructions on how to create them can be found [here](https://developers.google.com/identity/sign-in/web/devconsole-project).

In case those environment variables conflict with existing ones you might have, you can load them only in the context of the project with [direnv](http://direnv.net/), which will load the contents of a git ignored `.secrets` file. There is a `.secrets.sample` you can copy to setup yours.

Finally, run the rails server:

```
$ rails s
```

As mentioned above, we've been deploying the live instance of the app to (Heroku)[http://www.heroku.com], so, in order to better simulate the production locally, you'll need **Foreman**, which comes with the **heroku toolbelt** software:

```
$ brew install heroku-toolbelt
```

Once that's done, simply run `$ foreman start`. That will spinup all the processes required to run the application, which are describe in the `Procfile`. The application will be available on port 5000 by default.

## Contributing

Feel free to fork the repository and submit pull-requests. People responsible for currently maintaing that:

* [vvgomes](http://github.com/vvgomes)
* [gregoriomelo](http://github.com/gregoriomelo)


---

