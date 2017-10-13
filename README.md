# Toadbot

This is a simple bot built in Ruby. Use if you want to be cool and also not losr.

## Simple Installation
You can clone or download the repo.

You will need some non-gem dependencies which are in **Manual Installation** below.

For a simple install, navigate, in a terminal, to the bot folder and run:
```bash
sudo bin/setup
```
This should automatically run the setup script in `bot folder/bin`.
If you get errors, or the script did not work, see **Manual Installation** below.

## Manual installation

### Gems
The bot has a gemspec for easy bundler install. If you want to easily install the dependencies for the bot, navigate in a terminal into the directory that resulted from cloning/downloading the bot and run:
```bash
sudo bundle install
```

Alternatively, you can install the gems manually.
You need the following gem libraries for the basic bot:
1. discordrb `gem install discordrb`
2. sqlite3 `gem install sqlite3`
3. sequel `gem install sequel`

### Non-gem Dependencies
You need the following non-gem libraries for the basic bot:
1. sqlite3 `sudo apt install sqlite3`

You need the following non-gem libraries for voice features:
1. libsodium `sudo apt install libsodium`
2. ffmpeg `sudo apt install ffmpeg`
3. frei0r-plugins `sudo apt install frei0r-plugins`
4. 

### Final steps
You will need to create a config. In the `config` folder, you will need a `config.yaml`.
Copy `config-example.yaml` and paste as `config.yaml`, or just edit the example and rename it.

You will need to create a database. In `lib/toadbot`, create a blank database titled `database.db`
You're ready now!

## Setup
When you have it on your *`computing device`*, navigate to the `config` folder and go through and fill the file out. Make sure to enter all information.

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/toady. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Toadbot project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/toady/blob/master/CODE_OF_CONDUCT.md).
