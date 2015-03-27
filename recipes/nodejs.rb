#
# Cookbook Name:: pm2
# Recipe:: nodejs
#
# Copyright 2015, Mindera
#

# Override install methods
node.override['nodejs']['install_method'] = node['pm2']['nodejs']['install_method']
node.override['nodejs']['npm']['install_method'] = node['pm2']['nodejs']['npm']['install_method']

# Install nodejs
include_recipe 'nodejs'
