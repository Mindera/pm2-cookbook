require 'spec_helper'

describe 'pm2::nodejs' do
  cached(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }
  cached(:node) { chef_run.node }

  it 'include the nodejs recipe' do
    expect(chef_run).to include_recipe('nodejs')
  end
end
