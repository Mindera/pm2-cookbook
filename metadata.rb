name 'pm2'
maintainer 'Mindera'
maintainer_email 'miguel.fonseca@mindera.com'
license 'MIT'
description 'Installs/Configures PM2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.7.4'

depends 'poise-javascript', '~> 1.1.0'

supports 'centos', '~> 6.0'
supports 'redhat', '~> 6.0'
supports 'ubuntu', '~> 14.0'
supports 'debian', '~> 7.8'
supports 'amazon'
