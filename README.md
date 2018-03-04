# RBStarbound

This is a library to parse
[Starbound's](https://playstarbound.com/)
file formats which are used to store worlds, player characters, assets, etc.

Frankly, it's just a ruby version of
[py-starbound](https://github.com/blixt/py-starbound).
All thanks to
[blixt](https://github.com/blixt).

--------------------------------------------------------------------------------
## Installation

#### I. option

Add this line to your application's Gemfile:

```ruby
gem 'rbstarbound'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rbstarbound

#### II. option

You just

    $ git clone https://github.com/JetPirate/rb-starbound.git
    $ cd rb-starbound

--------------------------------------------------------------------------------

## Usage

### with executables

To get YAML file with all parsed player data:

**Attention: will be changed!**

    $ ./bin/rbstarbound path/to/save/file path/to/output/file

... will be added ...

### with the gem/library

#### Exapmle 1: Get the player name

```ruby

require 'rbstarbound'

path = 'path/to/your/save/file'
player = RBStarbound.parse_player_save_file(path)
# simple way
puts player.player_name
# advanced way
puts player['data']['identity']['name']

```

... will be added ...

--------------------------------------------------------------------------------

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Feel free to contribute either via submitting pull requests or writing up
issues with suggestions and/or bugs.

Bug reports and pull requests are welcome on GitHub at
https://github.com/JetPirate/rb-starbound.
This project is intended to be a safe, welcoming space for collaboration, and
contributors are expected to adhere to the
[Contributor Covenant](http://contributor-covenant.org)
code of conduct.

--------------------------------------------------------------------------------

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RBStarbound project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct
](https://github.com/JetPirate/rb-starbound/blob/master/CODE_OF_CONDUCT.md).
