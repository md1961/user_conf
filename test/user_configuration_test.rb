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

  def test_self_names_eq_for_creating_getter_and_setter
    UserConfiguration.names = [:an_attribute]

    uc = UserConfiguration.new
    uc.user = User.create!(name: 'whoever', password: 'whatever')

    the_value = :the_value_you_never_guess
    uc.an_attribute = the_value
    assert_equal(the_value, uc.an_attribute, "UserConfiguration#an_attribute()")
  end

  def test_user
    uc = UserConfiguration.new
    uc.instance_variable_set(:@user, :a_user_mock)
    assert_equal(:a_user_mock, uc.user, "UserConfiguration.user()")
  end

  def test_user_eq
    user = User.new
    uc = UserConfiguration.new
    uc.user = user
    assert_equal(user, uc.instance_variable_get(:@user), "@user of UserConfiguration")
  end

  def test_user_id_eq
    user = User.create!(name: 'whoever', password: 'whatever')
    uc = UserConfiguration.new
    uc.user_id = user.id
    assert_equal(user, uc.instance_variable_get(:@user), "@user of UserConfiguration")
  end
end

