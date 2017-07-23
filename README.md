# FancyPrint

FancyPrint allows you to "print" all kinds of "data" to your web browser as your new "stdout".

Here is how it works:

1. You fire up the app with `$ fancy server` and visit the webpage
2. Now you "print" to the browser from your command line: `$ fancy plot <data>`
3. Your browser now displays a fancy JavaScript plot of your data

Whenever you issue a new `fancy` CLI call with a new hunk of "data", it gets added to the top of the same webpage so that you have a record of all the recent "prints" issued to the same running instance of FancyPrint. WebSockets ensure that the page updates automatically without you having to refresh the page manually.

The following data types are supported right now:

- `plot`: A line plot (there is also a `--scatter` option for scatter plots)
- `diff`: A diff of two strings
- `text`: Unstyled text
- `markup`: Marked-up text with the markup language of your choice (e.g. `markdown`)
- `html`: Rendered HTML
- `svg`: Rendered SVG
- `image`: An image file
- `table`: A data table
- `haml`: Renderd HAML

Most data types offer an option to either take the data directly (from the command line when using the CLI client) or to read it from a file.

For info on how to structure the data, consult the documentation in `doc/`.

You can interact with a running FancyPrint instance in three different ways:

- with the CLI client (`fancy`)
- with the REST-API
- with the Ruby client library

## Usage

```
Usage:
  fancy -h|--help
  fancy server [--host=<hostname>] [-p=<port>|--port=<port>] [--websocket-port=<ws_port>] [--websocket-host=<ws_host>] [--no-xss]
  fancy plot [<data>|-f <file>] [--scatter] [--msg=<message>]
  fancy diff [<string1> <string2>|--file1=<file1> --file2=<file2>] [--msg=<message>]
  fancy text [<string>|-f <file>] [--highlight=<strings>|--regex=<regexps>] [--msg=<message>]
  fancy markup [<string>|-f <file>] --lang=<extension> [--msg=<message>]
  fancy html [<string>|-f <file>] [--msg=<message>]
  fancy svg [<string>|-f <file>] [--msg=<message>]
  fancy image <file> [--msg=<message>]
  fancy table [<data>|-f <file>] [--head] [--msg=<message>]
  fancy haml [<string>|-f <file>] [--msg=<message>]
```

For an in-depth description see here:

- [API Documentation](doc/api/api.md)
- [CLI Documentation](doc/api/cli.md)
- [Client Documentation](doc/api/client.md)

The [CONTRIBUTING.md](CONTRIBUTING.md) file gives a few development-related hints.

## Installation

Add this to your Gemfile:

```
gem 'fancy_print'
```

Then run:

```
$ bundle
```

Or install it yourself like so:

```
$ gem install fancy_print
```
