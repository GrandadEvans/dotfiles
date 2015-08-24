# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'sass', :input => 'scss', :output => 'css'

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#

guard :shell do
  watch /.*/ do |m|
    m[0] + " has changed."
  end
end

guard 'phpunit', :tests_path => 'Tests', :cli => '--colors' do
  # Watch tests files
  watch(%r{^.+Test\.php$})

  # Watch library files and run their tests
  watch(%r{^Object/(.+)\.php}) { |m| "Tests/#{m[1]}Test.php" }
end

#guard :concat, type: "js", files: %w(), input_dir: "public/js", output: "public/js/all"

#guard :concat, type: "css", files: %w(), input_dir: "public/css", output: "public/css/all"

# Installed by guard-mocha-node
# JavaScript/CoffeeScript watchers
guard 'mocha-node', :mocha_bin => File.expand_path(File.dirname(__FILE__) + "/node_modules/mocha/bin/mocha") do
  watch(%r{^spec/(.+)_spec\.(js\.coffee|js|coffee)})  { |m| "spec/#{m[1]}_spec.#{m[2]}" }
  watch(%r{^lib/(.+)\.(js\.coffee|js|coffee)})        { |m| "spec/lib/#{m[1]}_spec.#{m[2]}" }
  watch(%r{spec/spec_helper\.(js\.coffee|js|coffee)}) { "spec" }
end

#guard 'livereload' do
#  watch(%r{app/views/.+\.(erb|haml|slim)$})
#  watch(%r{app/helpers/.+\.rb})
#  watch(%r{public/.+\.(css|js|html)})
#  watch(%r{config/locales/.+\.yml})
#  # Rails Assets Pipeline
#  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html))).*}) { |m| "/assets/#{m[3]}" }
#end

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#

# Guard::Compass
#
# You don't need to configure watchers for guard 'compass' declaration as they generated
# from your Compass configuration file. You might need to define the Compass working directory
# and point to the configuration file depending of your project structure.
#
# Available options:
#
# * :workging_directory => Define the Compass working directory, relative to the Guardfile directory
# * :configuration_file => Path to the Compass configuration file, relative to :project_path
#
# Like usual, the Compass configuration path are relative to the :project_path

# guard 'compass', :project_path => 'not_current_dir', :configuration_file => 'path/to/my/compass_config.rb'
#guard :compass

# This will concatenate the javascript files specified in :files to public/js/all.js
#guard :concat, type: "js", files: %w(), input_dir: "public/js", output: "public/js/all"

#guard :concat, type: "css", files: %w(), input_dir: "public/css", output: "public/css/all"

guard :webpack, colors: true,  progress: true
