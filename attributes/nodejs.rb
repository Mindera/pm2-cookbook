#
# Cookbook Name:: pm2
# Attributes:: nodejs
#
# Copyright 2015, Mindera
#

default_unless['pm2']['nodejs']['install_method'] = 'package'
default_unless['pm2']['nodejs']['npm']['install_method'] = 'embedded'
