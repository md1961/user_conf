require 'test_helper'

TEST_DIR = File.join(File.dirname(__FILE__), 'test')
TESTERS = Dir.entries(TEST_DIR).grep(/_test\.rb$/)

INDENT = ' ' * 2
puts "Testing with the followings in directory '#{TEST_DIR}':\n" \
     + TESTERS.map { |x| INDENT + x }.join("\n") + "\n\n"

TESTERS.each do |filename|
  require File.join(TEST_DIR, filename)
end

