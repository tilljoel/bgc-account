# encoding: utf-8

require 'rubygems'
require 'bundler'
require 'churn'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'rake/testtask'
require 'rubygems/tasks'
require 'rubocop/rake_task'

Gem::Tasks.new

Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.test_files = Dir['test/**/test_*.rb']
  test.verbose = true
end

begin
  require 'cane/rake_task'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.abc_max = 22
    cane.add_threshold 'coverage/covered_percent', :>=, 40
    cane.abc_glob = '{lib,test}/**/*.rb'
    cane.no_doc = true
    cane.style_glob = '{lib}/**/*.rb'
    # cane.no_style = true
    # cane.abc_exclude = %w(Foo::Bar#some_method)
  end

rescue LoadError
  warn "cane not available, quality task not provided."
end

desc 'Run rubocop to check coding style'
Rubocop::RakeTask.new(:rubocop)

task :default => :all

task :all do |t|
  Rake::Task["test"].invoke
  Rake::Task["rubocop"].invoke
  Rake::Task["quality"].invoke if Rake::Task.task_defined?("quality")
end

