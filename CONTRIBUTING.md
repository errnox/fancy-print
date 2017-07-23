# Contributing

# Basics

Starting the development server:

        rerun ./bin/fancy server -p 4321

POSTing sample data to the browser:

        ruby spec/client/post_manually.rb

Running the complete test suite:

        RACK_ENV="test" rspec -c spec

Loading the fixtures into the test DB:

        RACK_ENV="test" rake db:fixtures:load

Accessing the DB shell (Be sure to do this from FancyPrint's root
directory!):

        # On the command line:
        RACK_ENV="test" irb
        # Inside the REPL:
        require_relative 'lib/fancy_print/web_app/app'
        # Now you can create/delete/list/... objects:
        Output.count

# Adding a new output type

When adding a new output type, do this:

1. Add a test for the new output type.
2. Update the server to support the new type.
3. Update the front end to support the new type.
4. Add a method for the new type to the client (be sure to also attach a
   method to `Object` which acts as a proxy for the cient method).
5. Add a command line option to the CLI.

Model the new output type like the existing ones (e.g. provide a
`--msg` option for the command line interface and a `:msg` option for the
client).
