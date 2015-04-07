#
# Cookbook Name:: pm2
# Library:: helpers.rb
#
# Copyright 2015, Mindera
#

def resource_attrs
  %w(
    name
    script
    args
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
    env
    log_data_format
    min_uptime
    max_restarts
    exec_mode
    exec_interpreter
    write
    force
  )
end

def pm2_is_app_online?(name)
  cmd = shell_out!('pm2 list', :returns => 0)
  not cmd.stdout.match(name).nil?
end

def pm2_start_app(name, filename)
  execute "pm2 start #{filename}" do
    command "pm2 start #{filename}"
    not_if pm2_is_app_online?(name)
  end
end

def pm2_stop_app(name)
  execute "pm2 stop #{name}" do
    command "pm2 stop #{name}"
    only_if pm2_is_app_online?(name)
  end
end

def pm2_restart_app(name)
  execute "pm2 restart #{name}" do
    command "pm2 restart #{name}"
  end
end

def pm2_reload_app(name)
  execute "pm2 reload #{name}" do
    command "pm2 reload #{name}"
    only_if pm2_is_app_online?(name)
  end
end

def pm2_graceful_reload_app(name)
  execute "pm2 gracefulReload #{name}" do
    command "pm2 gracefulReload #{name}"
    only_if pm2_is_app_online?(name)
  end
end

def pm2_startup(environment)
  execute "pm2 startup #{environment}"do
    command "pm2 startup #{environment}"
  end
end

def pm2_save_apps
  execute 'pm2 save' do
    command 'pm2 save'
  end
end

def pm2_start_or_restart_app(filename)
  execute "pm2 startOrRestart #{filename}" do
    command "pm2 startOrRestart #{filename}"
  end
end

def pm2_start_or_reload_app(filename)
  execute "pm2 startOrReload #{filename}" do
    command "pm2 startOrReload #{filename}"
  end
end

def pm2_start_or_graceful_reload_app(filename)
  execute "pm2 startOrGracefulReload #{filename}" do
    command "pm2 startOrGracefulReload #{filename}"
  end
end
