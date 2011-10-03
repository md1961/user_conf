require 'test_helper'

[
  'user_configuration_name_test',
  'user_configuration_value_test',
  'user_configuration_value_accessors_test',
].each do |basename|
  require File.join(File.dirname(__FILE__), 'test', basename)
end

