# Ask

Ask is a web application to help people saving, sharing, and liking their favorite interview questions. The application is currently intended to be used internally at [ThoughtWorks®](http://www.thoughtworks.com), so users are required to authenticate using their Thoughtworks [Okta](https://thoughtworks.okta.com) credentials.

![App Screenshot](https://d1ro8r1rbfn3jf.cloudfront.net/ms_8610/oFU8ekpXkKDtl8d2urQvN3cGjnMGgP/Ask.png?Expires=1428081035&Signature=MREBcka8ClCSgLF20YRFn9STgdNXP4OEdpys4rzyQpGlNRZogQwhlyW9fu1NuURpBHfdP6ksXg-6WreFuqnoaTSlY9DvgoNoFmJwzRzIVRUtFIOvEgvE~fD~f9cc2SdYy3pm1M1f0YSFv85hfPtPCdLdH09Q37ch4BraujL9khVi3z~U~pyC1-eLXGjBTGx5oo7ZWR2U4aEWnWy6qBl18aQ85K4a9kg1sCv48b7-j35dHKcVGfoOTsov6xkm3uQNeAPLWuTy65yvgCGoNkuczBMaklarMabj2ofF0JnK5zMcMRYFV6adpl7~2D4fMpxniJz8yHgXUDzPEx16OOLpsw__&Key-Pair-Id=APKAJHEJJBIZWFB73RSA)

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

Before running the server you will have to set two environment vars: `IDP_SSO_TARGET_URL` and `IDP_CERT_FINGERPRINT`. Assuming you have an [Okta Preview](https://thoughtworks-admin.oktapreview.com) account, get the target url & certificate from the *okta-localhost* app to run in development mode. Finally, run the rails server:

```
$ rails s -p 4567
```

Note that you need to specify the port because the server will connect to the [Okta Sample App](https://thoughtworks.oktapreview.com/app/UserHome) to perform authentication for localhost. You'll need an Okta Preview account to successfuly sign-in (a regular Okta account won't work).

## Contributing

Feel free to fork the repository and submit pull-requests.
