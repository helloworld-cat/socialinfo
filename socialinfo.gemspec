# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'socialinfo/version'

Gem::Specification.new do |gem|
  gem.name          = "socialinfo"
  gem.version       = Socialinfo::VERSION
  gem.authors       = ["Sam"]
  gem.email         = ["samuel@pagedegeek.com"]
  gem.description   = %q{retrieve information from social networks (Facebook, Twitter, etc.) about an url.}
  gem.summary       = %q{use: socialinfo <url>}
  gem.homepage      = "http://github.com/PagedeGeek/socialinfo"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib", "bin"]
end
