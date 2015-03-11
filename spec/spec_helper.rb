require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet'
require 'yarjuf'

hiera_path = File.expand_path(File.join(__FILE__, '..', '..' , 'spec', 'config', 'hiera'))
puts File.join(hiera_path,'hiera.yaml')

RSpec.configure do |c|
    c.hiera_config = File.join(hiera_path, 'hiera.yaml')
end

at_exit { RSpec::Puppet::Coverage.report! }
