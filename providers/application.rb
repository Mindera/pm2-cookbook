#
# Cookbook Name:: pm2
# Provider:: application
#
# Copyright 2015, Mindera
#

use_inline_resources

action :deploy do
  Chef::Log.info "Deploying pm2 application #{new_resource.name}"

  # Save resource config
  config = {}
  resource_attrs.each do |key|
    config[key] = eval("new_resource.#{key}") unless eval("new_resource.#{key}.nil?")
  end

  # Make sure the pm2 config dir exist
  directory '/etc/pm2/conf.d' do
    recursive true
    owner 'root'
    group 'root'
    action :create
  end

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
  Chef::Log.info "Starting pm2 application #{new_resource.name}"

  # Start pm2 application pm2_config = "/etc/pm2/conf.d/#{resource.name}.json"
  pm2_command("start #{pm2_config}") unless pm2_app_online?
end

action :delete do
  Chef::Log.info "Deleting pm2 application #{new_resource.name}"

  # Stop pm2 application
  pm2_command("stop #{new_resource.name}") if pm2_app_online?

  # Remove pm2 application json config
  file pm2_config do
    action :delete
    only_if { ::File.exist?(pm2_config) }
  end
end

action :stop do
  Chef::Log.info "Stopping pm2 application #{new_resource.name}"

  # Stop pm2 application
  pm2_command("stop #{new_resource.name}") if pm2_app_online?
end

action :restart do
  Chef::Log.info "Restarting pm2 application #{new_resource.name}"

  # Restart pm2 application
  pm2_command("restart #{new_resource.name}")
end

action :reload do
  Chef::Log.info "Reloading pm2 application #{new_resource.name}"

  # Reload pm2 application
  pm2_command("reload #{new_resource.name}")
end

action :graceful_reload do
  Chef::Log.info "Gracefully reloading pm2 application #{new_resource.name}"

  # Gracefully reload pm2 application
  pm2_command("gracefulReload #{new_resource.name}") if pm2_app_online?
end

action :start_or_restart do
  Chef::Log.info "Start or restart pm2 application #{new_resource.name}"

  # Start or restart pm2 application
  pm2_command("startOrRestart #{pm2_config}")
end

action :start_or_reload do
  Chef::Log.info "Start or reload pm2 application #{new_resource.name}"

  # Start or reload pm2 application
  pm2_command("startOrReload #{pm2_config}")
end

action :start_or_graceful_reload do
  Chef::Log.info "Start or gracefully reload pm2 application #{new_resource.name}"

  # Start or gracefully reload pm2 application
  pm2_command("startOrGracefulReload #{pm2_config}")
end

action :startup do
  Chef::Log.info "Start or gracefully reload pm2 application #{new_resource.name}"

  # Set startup based on platform
  cmd = "pm2 startup #{node['platform']}"
  # Add the user option if doing it as a different user
  cmd << " -u #{new_resource.user}"
  execute cmd do
    environment pm2_environment
    command cmd
  end
end

def pm2_config
  "/etc/pm2/conf.d/#{new_resource.name}.json"
end

def pm2_command(pm2_command)
  cmd = "pm2 #{pm2_command}"
  execute cmd do
    command cmd
    user new_resource.user
    environment pm2_environment
  end
end

def pm2_app_online?
  cmd = shell_out!('pm2 list',
                   :user => new_resource.user,
                   :returns => 0,
                   :environment => pm2_environment)
  !cmd.stdout.match(new_resource.name).nil?
end

def pm2_home
  if new_resource.home.nil?
    "#{::Dir.home(new_resource.user)}/.pm2"
  else
    if %r{/\.pm2/*$}.match(new_resource.home)
      new_resource.home
    else
      "#{new_resource.home}/.pm2"
    end
  end
end

def pm2_environment
  { 'PM2_HOME' => pm2_home }
end

def resource_attrs
  %w(
    name
    script
    args
    env
    node_args
    max_memory_restart
    instances
    log_file
    error_file
    out_file
    pid_file
    cron_restart
    cwd
    merge_logs
    watch
    ignore_watch
    watch_options
    log_data_format
    min_uptime
    max_restarts
    exec_mode
    exec_interpreter
    write
    force
  )
end
