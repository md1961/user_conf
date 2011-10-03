require 'test_helper'

class UserConfigurationTest < ActiveSupport::TestCase

  def test_self_names
    assert_equal([], UserConfiguration.names, "UserConfiguration.names() without setting any names")
  end

  NAMES = [:name_first, :name_second, :name_third]

  def test_self_names_eq
    UserConfiguration.names = NAMES

    assert_equal(NAMES.sort, UserConfiguration.names.sort, "UserConfiguration.names() after setting one")
    NAMES.each do |name|
      assert_not_nil(UserConfigurationName.find_by_name(name.to_s), "UserConfigurationName with a name of '#{name}' should exist")
    end
  end
end

