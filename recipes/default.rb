#
# Cookbook Name:: pm2
# Recipe:: default
#
# Copyright 2015, Mindera
#

# Constants
PM2_VERSION = node['pm2']['version']

# Install npm
include_recipe 'pm2::nodejs'

# Install pm2
nodejs_npm 'pm2' do
  version PM2_VERSION unless PM2_VERSION.nil?
end
