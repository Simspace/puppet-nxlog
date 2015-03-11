require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'

# Project root
proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

proxy_host = "http://llproxy:8080" # ENV['BEAKER_PACKAGE_PROXY'] || ''
no_proxy = "localhost,127.0.0.1,llcad-github,*.llan.ll.mit.edu"

if !proxy_host.empty?
  gem_proxy = "http_proxy=#{proxy_host}" unless proxy_host.empty?

  hosts.each do |host|
    on host, "echo 'export http_proxy=#{proxy_host}' >> /root/.bashrc"
    on host, "echo 'export HTTP_PROXY=#{proxy_host}' >> /root/.bashrc"
    on host, "echo 'export https_proxy=#{proxy_host}' >> /root/.bashrc"
    on host, "echo 'export HTTPS_PROXY=#{proxy_host}' >> /root/.bashrc"
    on host, "echo 'export no_proxy=\"#{no_proxy},#{host.name}\"' >> /root/.bashrc"
    on host, "source /root/.bashrc"
    on host, "echo 'Acquire::http::Proxy \"#{proxy_host}\";' >> /etc/apt/apt.conf"
    on host, "echo 'Acquire::https::Proxy \"#{proxy_host}\";' >> /etc/apt/apt.conf"
  end
else
  gem_proxy = ''
end

unless ENV['RS_PROVISION'] == 'no' or ENV['BEAKER_provision'] == 'no'
  hosts.each do |host|
       on host, "mkdir -p #{host['distmoduledir']}"
  end
end

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    # Install module and dependencies
    puppet_module_install(:source => proj_root, :module_name => 'todo')
    proxy = "http_proxy=#{proxy_host} https_proxy=#{proxy_host} no_proxy=\"#{no_proxy}\""
    hosts.each do |host|
      on host, "#{proxy} puppet module install puppetlabs-stdlib", { :acceptable_exit_codes => [0,1] }
    end
  end
end
