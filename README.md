# PeriodicTable

The PeriodicTable CLI gem is designed to mimic a real Periodic Table by displaying all 118 elements and providing information about each of their properties.

## Introduction

Welcome to the PeriodicTable CLI! If you're here to study chemistry and need some information to reference, or if you just want to get your feet wet with chemistry, then you've come to the right place. (Though be careful not to get your feet wet with the wrong chemicals!)

Disclaimer: This probably won't look like any Periodic Table you've ever seen, but the information presented is accurate.

## Motivation

This gem was built by a student for Flatiron School's CLI Data Gem Portfolio Project. It is meant to demonstrate a student's knowledge of the basics of procedural and object-oriented Ruby and with building a CLI. He chose to make an interactive PeriodicTable CLI because chemistry was one of his favorite school subjects.

## Gems Used

The following gems were used to make this program: Bundler, Rake, Rspec, Pry, Nokogiri, and Colorize.

## Installation

This gem is not yet available on [rubygems.org](https://rubygems.org) and therefore cannot be added to your Gemfile. (There is a periodic_table gem available on [rubygems.org](https://rubygems.org), but it is not the same as this one.)

To install this gem, fork and clone it from its Github repository at [https://github.com/Sdcrouse/periodic-table-cli-gem](https://github.com/Sdcrouse/periodic-table-cli-gem).

## Usage

This gem will allow you to view a list of all 118 chemical elements currently known as of 2018. If you'd rather not get overwhelmed by all of those elements, there are also options for displaying shorter lists of elements.

Within each list, there is an option to examine an individual element for more information. All of this information has been scraped from [Wikipedia's List of Chemical Elements](https://en.wikipedia.org/wiki/List_of_chemical_elements).

You are also able to sort the list of all 118 chemical elements alphabetically by name.

To run the PeriodicTable CLI gem, enter the following lines of code:

    $ cd periodic-table-cli-gem
    $ bin/periodic-table

Follow the prompts from there, and have fun! 

To see the Periodic Table CLI in action, [click here for a walkthrough video](https://www.useloom.com/share/a51352ba5ccb4f06b11eceeaf403844c).

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. (Note: there are only two tests at this time. The first tests for a version number. The second makes sure that the CLI scrapes the Periodic Table and creates new Elements.) You can also run `bin/console` for an interactive prompt that will allow you to experiment.

Please note that the Pry gem is a development-only dependency, so it shouldn't be required in the `config/environment.rb` file used by the CLI itself; otherwise, it will output a `LoadError` when you run `bin/periodic-table`. If you want to use the Pry gem in development, don't run it through `bin/periodic-table`; use `bin/console` instead.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

There is also a NOTES.md file that contains ideas for more features and new versions of the gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/Sdcrouse/periodic-table-cli-gem](https://github.com/Sdcrouse/periodic-table-cli-gem). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PeriodicTable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the code of conduct (see the CODE_OF_CONDUCT.md file for more information).
