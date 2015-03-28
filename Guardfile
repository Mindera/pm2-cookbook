# Guardfile

# TODO: commented because the guard-foodcritic plugin has deps issues
# Foodcritic
#guard :foodcritic, :cookbook_paths => '.', :all_on_start => false, :cli => '--epic-fail any' do
#  watch(%r{attributes/.+\.rb$})
#  watch(%r{providers/.+\.rb$})
#  watch(%r{recipes/.+\.rb$})
#  watch(%r{resources/.+\.rb$})
#  watch(%r{libraries/.+\.rb$})
#  watch('metadata.rb')
#end

# ChefSpec
guard :rspec, cmd: 'bundle exec rspec', all_on_start: true do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^(recipes)/(.+)\.rb$})   { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')      { 'spec' }
end

# RuboCop
guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end