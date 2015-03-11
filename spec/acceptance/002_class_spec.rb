require 'spec_helper_acceptance'

proxy_host = "http://llproxy:8080" # ENV['BEAKER_PACKAGE_PROXY'] || ''
no_proxy = "localhost,127.0.0.1,llcad-github,*.llan.ll.mit.edu"
puppet_proxy = { :http_proxy => "#{proxy_host}", :https_proxy=> "#{proxy_host}", :no_proxy => "#{no_proxy}" }

describe "todo class" do
  it 'should apply with no errors' do
    pp = <<-EOS
    EOS
    # Run it twice and test for idempotency
    opts = { :modulepath => "#{default['distmoduledir']}",
             :environment => puppet_proxy}
    expect(apply_manifest(pp,opts).exit_code).to_not eq(1)
    expect(apply_manifest(pp,opts).exit_code).to eq(0)
  end
end
