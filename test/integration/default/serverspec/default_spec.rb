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
