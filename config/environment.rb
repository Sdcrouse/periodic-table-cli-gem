require "pry"
require "open-uri"
require "nokogiri"

# Be VERY careful about the order in which you call these files!
require_relative "../lib/periodic_table/version"
require_relative "../lib/periodic_table/cli"
require_relative "../lib/periodic_table/elements"
require_relative "../lib/periodic_table/table_scraper.rb"
