require 'test_helper'

TEST_DIR = File.join(File.dirname(__FILE__), 'test')

Dir.entries(TEST_DIR).grep(/_test\.rb$/).each do |filename|
  require File.join(TEST_DIR, filename)
end

