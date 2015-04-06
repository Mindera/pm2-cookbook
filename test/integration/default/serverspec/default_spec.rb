require 'serverspec'

# Required by serverspec
set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin:$PATH'
  end
end

%w(
  nodejs
  npm
).each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe command('pm2 --version') do
  its(:exit_status) { should eq 0 }
end

describe file('/etc/pm2/conf.d/test.json') do
  it { should be_file }
  it { should contain 'test.js' }
end

describe command('pm2 status test') do
  its(:stdout) { should contain 'online' }
end

describe command('chkconfig --list | grep 3:on | grep pm2-init.sh') do
  its(:exit_status) { should eq 0 }
end
