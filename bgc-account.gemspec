# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bgc/account/version'

Gem::Specification.new do |s|
  s.name          = "bgc-account"
  s.version       = BGC::Account::VERSION
  s.authors       = ["Joel Larsson"]
  s.email         = ["tilljoel@gmail.com"]
  s.description   = 'BGC, Bankgirocentralen - Swedish bank account numbers, validate and normalize accounts'
  s.summary       = 'BGC, Bankgirocentralen - Swedish bank account numbers, validate and normalize accounts'
  s.homepage      = 'http://github.com/tilljoel/bgc-account'
  s.license       = "MIT"
  s.files         = `git ls-files`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.rdoc_options  = ['--charset=UTF-8']
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'activemodel',        '~> 3.2.13'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler',            '~> 1.3'
  s.add_development_dependency 'rubocop',            '~> 0.14.1'
  s.add_development_dependency 'churn',              '~> 0.0.34'
  s.add_development_dependency 'simplecov',          '~> 0.7.1'
  s.add_development_dependency 'mocha',              '~> 0.13.3'
  s.add_development_dependency 'minitest',           '~> 4.4.0'
  s.add_development_dependency 'minitest-focus',     '~>1.0.0'
  s.add_development_dependency 'minitest-reporters', '~> 0.12.0'
  s.add_development_dependency 'cane',               '~> 2.5.2'
  s.add_development_dependency 'awesome_print',      '~> 1.1.0'
#  s.add_development_dependency 'pry',                '~> 0.9.12'
#  s.add_development_dependency 'pry-debugger',       '~> 0.2.2'
  s.add_development_dependency 'rubygems-tasks',     '~> 0.2.4'

end
