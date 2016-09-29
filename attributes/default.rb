#
# Cookbook Name:: pm2
# Attributes:: default
#
# Copyright 2015, Mindera
#

default_unless['pm2']['pm2_version'] = 'latest'
default_unless['pm2']['npm_version'] = 'latest'
default_unless['pm2']['node_version'] = '4.5.0'
