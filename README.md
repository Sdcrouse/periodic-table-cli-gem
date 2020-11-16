# PeriodicTable

Welcome to the PeriodicTable CLI! If you're here to study chemistry and need some information to reference, or if you just want to get your feet wet with chemistry, then you've come to the right place. (Though be careful not to get your feet wet with the wrong chemicals!)

*Disclaimer:* This probably won't look like any Periodic Table you've ever seen, but the information presented is accurate as of November 2020.

## Description

The PeriodicTable CLI is a Ruby gem designed to mimic a real Periodic Table by displaying all 118 curently known elements and providing information about each of their properties. I built this as my first project for Flatiron School.

To see the Periodic Table CLI in action, [click here for a walkthrough video](https://www.useloom.com/share/a51352ba5ccb4f06b11eceeaf403844c).

## Installation

This gem is not yet available on [rubygems.org](https://rubygems.org) and therefore cannot be added to your Gemfile. (There is a periodic_table gem available on [rubygems.org](https://rubygems.org), but it is not the same as this.)

To install the Periodic Table CLI gem, fork and clone it from its Github repository at [https://github.com/Sdcrouse/periodic-table-cli-gem](https://github.com/Sdcrouse/periodic-table-cli-gem). Then run `bin/setup` to install its dependencies.

## Starting Up the App

To run the PeriodicTable CLI gem, enter the following lines of code:

    $ cd periodic-table-cli-gem
    $ bin/periodic-table

Follow the prompts from there, and have fun! 

## Usage

As mentioned above, the Periodic Table CLI will allow you to view a list of all 118 chemical elements currently known as of 2020. If you'd rather not get overwhelmed by seeing all of those elements at once, there are also options for displaying shorter lists of elements.

Within each list, there is an option to examine an individual element for more information. All of this information has been scraped from [Wikipedia's List of Chemical Elements](https://en.wikipedia.org/wiki/List_of_chemical_elements).

You are also able to sort the list of all 118 chemical elements alphabetically by name.

## Gems Used

The following gems were used to make the Periodic Table CLI: Bundler, Rake, Rspec, Pry, Nokogiri, and Colorize.

## Development

Use the `rake spec` command to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Please note that the Pry gem is a development-only dependency, so it shouldn't be required in the `config/environment.rb` file used by the CLI itself; otherwise, it will output a `LoadError` when you run `bin/periodic-table`. If you want to use the Pry gem in development, require it in the `bin/console` file and run the `bin/console` command.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

There is also a NOTES.md file that contains ideas for more features and new versions of the gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/Sdcrouse/periodic-table-cli-gem](https://github.com/Sdcrouse/periodic-table-cli-gem). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PeriodicTable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct (see the CODE_OF_CONDUCT.md file for more information).
