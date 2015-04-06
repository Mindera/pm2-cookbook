#
# Cookbook Name:: pm2_application_cookbook-test
# Recipe:: default
#
# Copyright 2015, Mindera
#

include_recipe 'pm2::default'

cookbook_file '/tmp/test.js' do
  source 'test.js'
end

pm2_application 'test' do
  script 'test.js'
  cwd '/tmp'
  action [:deploy, :start_or_reload, :startup]
end
