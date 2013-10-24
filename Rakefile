# -*-ruby-*-
require "bundler/gem_tasks"
require "rake/testtask"

task :default => [:test]

Rake::TestTask.new do |t|
  # we need to chdir to test directory before running
  t.ruby_opts = ['-C', 'test']
  t.test_files = FileList['test/test_*.rb'].map {|idx| idx.sub(/^test\//, '') }
#  t.verbose = true
end
