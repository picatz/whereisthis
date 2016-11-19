# Whereisthis

This gem is meant to be simple, easy to operate command-line application to help determine the location information from a given ip address or url.

## Installation

    $ gem install whereisthis

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

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/whereisthis. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

