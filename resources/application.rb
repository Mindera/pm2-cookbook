#
# Cookbook Name:: pm2
# Resource:: application
#
# Copyright 2015, Mindera
#

actions :deploy,
        :start,
        :stop,
        :restart,
        :reload,
        :graceful_reload,
        :start_or_restart,
        :start_or_reload,
        :start_or_graceful_reload,
        :delete

default_action :start

attribute :name, :name_attribute => true, :kind_of => String
attribute :script, :kind_of => String, :required => true
# args can be an array or a string so we go with Array
attribute :args, :kind_of => Array
# node_args can be an array or a string so we go with Array
attribute :node_args, :kind_of => Array
attribute :max_memory_restart, :kind_of => String
attribute :instances, :kind_of => Integer
# log_file can be a bool or string so we go with Array
attribute :log_file, :kind_of => String
attribute :error_file, :kind_of => String
attribute :out_file, :kind_of => String
attribute :pid_file, :kind_of => String
attribute :cron_restart, :kind_of => String
attribute :cwd, :kind_of => String, :required => true
attribute :merge_logs, :kind_of => [TrueClass, FalseClass]
attribute :watch, :kind_of => [TrueClass, FalseClass]
# ignore_watch can be an array or string so we go with Array
attribute :ignore_watch, :kind_of => Array
# watch_options a js object so we go with Hash
attribute :watch_options, :kind_of => Hash
# env is a js object or string so we go with Hash
attribute :env, :kind_of => Hash
attribute :log_data_format, :kind_of => String
# min_uptime is a string or number so we go with String
attribute :min_uptime, :kind_of => String
attribute :max_restarts, :kind_of => Integer
attribute :exec_mode, :kind_of => String
attribute :exec_interpreter, :kind_of => String
attribute :write, :kind_of => [TrueClass, FalseClass]
attribute :force, :kind_of => [TrueClass, FalseClass]
