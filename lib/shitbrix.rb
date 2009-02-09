$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'shitbrix/injector.rb'
require 'shitbrix/abstract_module.rb'
require 'shitbrix/base_container.rb'
require 'shitbrix/class_extensions.rb' # always should be last to prevent recursion