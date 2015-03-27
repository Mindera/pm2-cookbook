require 'chefspec'
require 'chefspec/berkshelf'
require 'chefspec/cacher'

RSpec.configure do |config|
  config.platform = 'centos'
  config.version = '6.5'
  config.log_level = :error
end

at_exit { ChefSpec::Coverage.report! }
