require 'spec_helper_acceptance'

# Here we put the more basic fundamental tests, ultra obvious stuff.
describe "basic tests:" do
  it 'make sure we have copied the module across' do
    shell("ls #{default['distmoduledir']}/todo/manifests", {:acceptable_exit_codes => 0})
  end
  #it 'make sure at least one dependency from llcad-github was installed with r10k' do
  #  shell("ls #{default['distmoduledir']}/llrange_prop/manifests", {:acceptable_exit_codes => 0})
  #end
  it 'make sure at least one dependency from puppetforge was installed with r10k' do
    shell("ls #{default['distmoduledir']}/stdlib/manifests", {:acceptable_exit_codes => 0})
  end
  #it 'make sure at least one dependency from github was installed with r10k' do
  #  shell("ls #{default['distmoduledir']}/kibana3/manifests", {:acceptable_exit_codes => 0})
  #end
end
