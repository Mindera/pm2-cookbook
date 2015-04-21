#
# Cookbook Name:: pm2_application_cookbook-test
# Recipe:: default
#
# Copyright 2015, Mindera
#

include_recipe 'pm2::default'

user 'nodeuser' do
  action :create
end

nodejs_dir = '/var/www/nodejs'
directory '/var/www/nodejs' do
  action :create
  recursive true
  owner 'nodeuser'
  group 'nodeuser'
end

template "#{nodejs_dir}/test.js" do
  variables('port' => 8000)
  source 'test.js'
end

template "#{nodejs_dir}/test_w_user.js" do
  variables('port' => 8001)
  source 'test.js'
end

pm2_application 'test_w_user' do
  script 'test_w_user.js'
  cwd nodejs_dir
  user 'nodeuser'
  home nodejs_dir
  action [:deploy, :start_or_reload, :startup]
end

pm2_application 'test' do
  script 'test.js'
  cwd nodejs_dir
  action [:deploy, :start_or_reload, :startup]
end
