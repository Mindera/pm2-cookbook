require 'spec_helper'

describe 'pm2::default' do
  cached(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  cached(:node) { chef_run.node }

  it 'include the pm2::nodejs recipe' do
    expect(chef_run).to include_recipe('pm2::nodejs')
  end

  it 'install the pm2 node module' do
    expect(chef_run).to install_nodejs_npm('pm2')
  end
end
