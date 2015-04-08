name             'pm2'
maintainer       'Mindera'
maintainer_email 'miguel.fonseca@mindera.com'
license          'MIT'
description      'Installs/Configures PM2'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.2'

depends 'nodejs', '~> 2.4.0'

supports 'centos', '~> 6.0'
supports 'amazon'
