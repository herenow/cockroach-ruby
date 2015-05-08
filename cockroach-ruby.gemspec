lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "cockroach-ruby"
  spec.version       = "0.0.1"
  spec.authors       = ["herenow"]
  spec.email         = ["leonardoshiro@gmail.com"]
  spec.summary       = "Ruby driver for cockroachdb"
  spec.description   = "A Cockroachdb client written in rubby."
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 2.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.2.3"
end
