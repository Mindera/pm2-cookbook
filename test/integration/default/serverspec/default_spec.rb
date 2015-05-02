require 'serverspec'

# Required by serverspec
set :backend, :exec

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin:$PATH'
  end
end

describe command('whoami') do
    its(:stdout) { should contain 'root' }
end

describe package('nodejs') do
  it { should be_installed }
end

describe command('npm --version') do
  its(:exit_status) { should eq 0 }
end

describe command('pm2 --version') do
  its(:exit_status) { should eq 0 }
end

describe file('/etc/pm2/conf.d/test.json') do
  it { should be_file }
  it { should contain 'test.js' }
end

describe file('/etc/pm2/conf.d/test_w_user.json') do
  it { should be_file }
  it { should contain 'test_w_user.js' }
end

describe command('su root -c "PM2_HOME=/root/.pm2 pm2 status test"') do
  its(:stdout) { should contain 'online' }
end

describe command('su nodeuser -c "PM2_HOME=/home/nodeuser/.pm2 pm2 status test_w_user"') do
  its(:stdout) { should contain 'online' }
end

describe command('ls /etc/rc3.d/S*pm2-init.sh') do
  its(:exit_status) { should eq 0 }
end

describe file('/etc/init.d/pm2-init.sh') do
  it { should be_file }
  it { should contain 'export PM2_HOME="/home/nodeuser/.pm2"' }
end
