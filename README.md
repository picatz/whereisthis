# Whereisthis

This gem is meant to be simple, easy to operate command-line application to help determine the location information from a given ip address or url.

## Screen Shot

![screen_shot](http://i.imgur.com/aUEqpFS.png)

## Installation

    $ gem install whereisthis

#### macOS Gem Install Note

By default, macOS will not install the command-line application in the `/usr/bin/` directory; and if you're not using something like RVM and you're getting a permissions error, then this should work:

    $ sudo gem install -n /usr/local/bin whereisthis

## Usage

Useage is meant to be fairly straightforward. The application even defaults to a help menu.

### Ip Address

Get all information about a particular ip address `8.8.8.8`:

```
$ whereisthis 8.8.8.8
```
or

```
$ whereisthis -i 8.8.8.8
```
### Url

Get all information about a particular url `www.google.com`:

```
$ whereisthis www.google.com
```
or

```
$ whereisthis -w www.google.com
```

### Help Menu

Help menu `-h` or `--help` or just run the application without any arguments:

```
  -c, --city           Show the city location information if possible
  -r, --region         Show the region location information if possible
  -C, --Country        Show the country location information if possible
  -g, --gps            Show the latitude and longitude information if possible
  -p, --postal         Show the postal information if possible
  -o, --org            Show the organization information if possible
  -H, --Hostname       Show the hostname information if possible
  -i, --ip=<s>         Specify the ip address to lookup
  -w, --website=<s>    Specify the website url to lookup
  -v, --version        Print version and exit
  -h, --help           Show this message
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

