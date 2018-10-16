
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "periodic_table/version"

Gem::Specification.new do |spec|
  spec.name          = "periodic_table"
  spec.version       = PeriodicTable::VERSION
  spec.authors       = ["'Steven Crouse'"]
  spec.email         = ["'sdcrouse91@gmail.com'"]

  spec.summary       = %q{An interactive Periodic Table for the chemist in all of us.}
  spec.description   = %q{The Periodic Table CLI acts as a reference for people who are interested in and/or studying chemistry. It allows them to see a list of all known chemical elements and examine each element for additional information.}
  spec.homepage      = "https://github.com/Sdcrouse/periodic-table-cli-gem"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
