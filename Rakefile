require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

# RuboCop and Foodcritic
namespace :lint do
  desc 'Run RuboCop checks'
  RuboCop::RakeTask.new(:rubocop)

  desc 'Run Foodcritic checks'
  FoodCritic::Rake::LintTask.new(:foodcritic) do |task|
    task.options = {  fail_tags: ['any'], tags: []  }
  end
end

# ChefSpec
namespace :unit do
  desc 'Run ChefSpec examples'
  RSpec::Core::RakeTask.new(:chefspec)
end

# Kitchen
namespace :integration do
  namespace :kitchen do
    desc 'Run Kitchen with Vagrant'
    task :vagrant do
      Kitchen.logger = Kitchen.default_file_logger
      Kitchen::Config.new.instances.each do |instance|
        instance.test(:always)
      end
    end
  end
end

desc 'Run Unit tests'
task unit: ['unit:chefspec']

desc 'Run Lint tests'
task lint: ['lint:rubocop', 'lint:foodcritic']

desc 'Run Integration tests'
task integration: ['integration:kitchen:vagrant']

# Travis
task travis: ['lint', 'unit']

# Default
task default: ['lint', 'unit', 'integration']
