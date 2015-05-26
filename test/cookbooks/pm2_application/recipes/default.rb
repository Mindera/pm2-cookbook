#
# Cookbook Name:: pm2_application_cookbook-test
# Recipe:: default
#
# Copyright 2015, Mindera
#

include_recipe 'pm2::default'

nodejs_dir = '/tmp'

%w(
  nodeuser
  nodeuserwithpm2home
).each do |u|
  user u do
    home "/home/#{u}"
    manage_home true
    action :create
  end
end

template "#{nodejs_dir}/test.js" do
  variables('port' => 8000)
  source 'test.js'
  notifies :graceful_reload, 'pm2_application[test]', :delayed
end

template "#{nodejs_dir}/test_w_user.js" do
  variables('port' => 8001)
  source 'test.js'
end

template "#{nodejs_dir}/test_w_user_w_pm2_home.js" do
  variables('port' => 8002)
  source 'test.js'
end

pm2_application 'test' do
  script 'test.js'
  cwd nodejs_dir
  action [:deploy, :start_or_reload, :startup]
end

pm2_application 'test_w_user_w_pm2_home' do
  script 'test_w_user_w_pm2_home.js'
  cwd nodejs_dir
  user 'nodeuserwithpm2home'
  home '/home/nodeuserwithpm2home/.pm2'
  action [:deploy, :start_or_reload, :startup]
end

pm2_application 'test_w_user' do
  script 'test_w_user.js'
  cwd nodejs_dir
  user 'nodeuser'
  home '/home/nodeuser'
  action [:deploy, :start_or_reload, :startup]
end
