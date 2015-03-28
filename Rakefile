require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

# RuboCop and Foodcritic
namespace :lint do
  desc 'Run RuboCop checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Foodcritic checks'
  FoodCritic::Rake::LintTask.new(:chef) do |task|
    task.options = {  fail_tags: ['any'], tags: []  }
  end
end

# ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

# Kitchen
namespace :integration do
  desc 'Run Kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
end

desc 'Run Unit tests'
task unit: ['spec']

desc 'Run Lint tests'
task lint: ['lint:ruby', 'lint:chef']

desc 'Run Integration tests'
task integration: ['integration']

# Travis
task travis: ['lint', 'unit']

# Default
task default: ['lint', 'unit', 'integration:vagrant']
