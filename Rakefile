require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint/tasks/puppet-lint'

# Lint settings, do not support puppet < 3.0
PuppetLint.configuration.send('disable_80chars')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')
PuppetLint.configuration.send('disable_class_parameter_defaults')
PuppetLint.configuration.ignore_paths = ["spec/**/*.pp", "pkg/**/*.pp"]

desc "Validate manifests, templates, and ruby files"
task :validate do
  Dir['manifests/**/*.pp'].each do |manifest|
    sh "puppet parser validate --noop #{manifest}"
  end
  Dir['spec/**/*.rb','lib/**/*.rb'].each do |ruby_file|
    sh "ruby -c #{ruby_file}" unless ruby_file =~ /spec\/fixtures/
  end
  Dir['templates/**/*.erb'].each do |template|
    sh "erb -P -x -T '-' #{template} | ruby -c"
  end
end
RSpec::Core::RakeTask.new(:spec_junit_standalone) do |t|
    t.pattern = 'spec/{classes,defines,unit,functions,hosts,integration}/**/*_spec.rb'
    t.rspec_opts = %w[-f JUnit -o results.xml --require spec_helper]
end
desc "Run rake spec with junit formatting"
task :spec_junit do
  Rake::Task[:spec_prep].invoke
  Rake::Task[:spec_junit_standalone].invoke
  Rake::Task[:spec_clean].invoke
end
desc "Run beaker acceptance tests with junit formatting"
RSpec::Core::RakeTask.new(:beaker_junit) do |t|
    t.rspec_opts = %w[-f JUnit -o results_beaker.xml --require spec_helper_acceptance]
    t.pattern = 'spec/acceptance'
end
