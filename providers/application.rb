#
# Cookbook Name:: pm2
# Provider:: application
#
# Copyright 2015, Mindera
#

use_inline_resources

action :deploy do
  resource = @new_resource
  Chef::Log.info "Deploying pm2 application #{resource.name}"

  # Save resource config
  config = {}
  resource_attrs.each do |key|
    config[key] = eval("resource.#{key}") unless eval("resource.#{key}.nil?")
  end

  # Make sure the pm2 config dir exist
  directory '/etc/pm2/conf.d' do
    recursive true
    owner 'root'
    group 'root'
    action :create
  end

  pm2_config = "/etc/pm2/conf.d/#{resource.name}.json"
  # Deploy pm2 application json config
  template pm2_config do
    source 'application.json.erb'
    variables(:config => config)
    cookbook 'pm2'
    mode '0644'
    backup false
  end
end

action :start do
  resource = @new_resource
  Chef::Log.info "Starting pm2 application #{resource.name}"

  # Start pm2 application
  pm2_config = "/etc/pm2/conf.d/#{resource.name}.json"
  pm2_start_app(resource.name, pm2_config)
end

action :delete do
  resource = @new_resource
  Chef::Log.info "Deleting pm2 application #{resource.name}"

  # Stop pm2 application
  pm2_stop_app(resource.name)

  # Remove pm2 application json config
  pm2_config = "/etc/pm2/conf.d/#{resource.name}.json"
  file pm2_config do
    action :delete
    only_if { ::File.exist?(pm2_config) }
  end
end

action :stop do
  resource = @new_resource
  Chef::Log.info "Stopping pm2 application #{resource.name}"

  # Stop pm2 application
  pm2_stop_app(resource.name)
end

action :restart do
  resource = @new_resource
  Chef::Log.info "Restarting pm2 application #{resource.name}"

  # Restart pm2 application
  pm2_restart_app(resource.name)
end

action :reload do
  resource = @new_resource
  Chef::Log.info "Reloading pm2 application #{resource.name}"

  # Reload pm2 application
  pm2_reload_app(resource.name)
end

action :graceful_reload do
  resource = @new_resource
  Chef::Log.info "Gracefully reloading pm2 application #{resource.name}"

  # Gracefully reload pm2 application
  pm2_graceful_reload_app(resource.name)
end

action :start_or_restart do
  resource = @new_resource
  Chef::Log.info "Start or restart pm2 application #{resource.name}"

  # Start or restart pm2 application
  pm2_config = "/etc/pm2/conf.d/#{resource.name}.json"
  pm2_start_or_restart_app(pm2_config)
end

action :start_or_reload do
  resource = @new_resource
  Chef::Log.info "Start or reload pm2 application #{resource.name}"

  # Start or reload pm2 application
  pm2_config = "/etc/pm2/conf.d/#{resource.name}.json"
  pm2_start_or_reload_app(pm2_config)
end

action :start_or_graceful_reload do
  resource = @new_resource
  Chef::Log.info "Start or gracefully reload pm2 application #{resource.name}"

  # Start or gracefully reload pm2 application
  pm2_config = "/etc/pm2/conf.d/#{resource.name}.json"
  pm2_start_or_graceful_reload_app(pm2_config)
end
