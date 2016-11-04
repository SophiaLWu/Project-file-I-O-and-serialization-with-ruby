# Hangman

This is a rendition of the classic Hangman game on the command line interface.

The project is described in the section [Project: File I/O and Serialization](http://www.theodinproject.com/courses/ruby-programming/lessons/file-i-o-and-serialization) from The Ruby Programming portion of The Odin Project.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hangman'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hangman

## Usage

Execute the following command to play the game:

    $ ruby play_game.rb

There are sample save files inside of the save folders if you would like to test loading a save file. Alternatively, you can save your own game while playing and load that at another time.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hangman. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

