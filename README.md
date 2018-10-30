# PeriodicTable

Welcome to the PeriodicTable CLI! If you're here to study chemistry and need some information to reference, or if you just want to get your feet wet with chemistry, then you've come to the right place. (Though be careful not to get your feet wet with the wrong chemicals!)

Disclaimer: This probably won't look like any Periodic Table you've ever seen.

## Motivation 

This gem was built by a student for Flatiron School's CLI Data Gem Portfolio Project. It is meant to demonstrate a student's knowledge of the basics of procedural and object-oriented Ruby and with building a CLI.

## Gems Used

The following gems were used to make this program: Bundler, Rake, Rspec, Pry, Nokogiri, and Colorize. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'periodic_table'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install periodic_table

## Usage

This gem will allow you to view a list of all 118 chemical elements currently known as of 2018. If you'd rather not get overwhelmed by all of those elements, there are also options for displaying shorter lists of elements.

Within each list, there is an option to examine an individual element for more information. All of this information has been scraped from [Wikipedia's List of Chemical Elements](https://en.wikipedia.org/wiki/List_of_chemical_elements).

You are also able to sort the list of all 118 chemical elements alphabetically by name.

Lastly, there is a NOTES.md file that contains ideas for more features and new versions of the gem.

To run the PeriodicTable CLI gem, enter the following lines of code:

    $ cd periodic-table-cli-gem
    $ bin/periodic-table

Follow the prompts from there, and have fun!

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. (Note: there are only two tests at this time. The first tests for a version number. The second makes sure that the CLI scrapes the Periodic Table and creates new Elements.) You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'Sdcrouse'/periodic_table. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PeriodicTable project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/Sdcrouse/periodic-table-cli-gem).
