require "open-uri"
require "nokogiri"
require "colorize"

# Be VERY careful about the order in which you call these files!
require_relative "../lib/periodic_table/version"
require_relative "../lib/periodic_table/cli"
require_relative "../lib/periodic_table/element"
require_relative "../lib/periodic_table/concerns/value_modifier"
require_relative "../lib/periodic_table/table_scraper"