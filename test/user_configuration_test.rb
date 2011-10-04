require 'test_helper'

class UserConfigurationTest < ActiveSupport::TestCase

  def test_initialize
    user = User.new
    uc = UserConfiguration.new(user)
    assert_equal(user, uc.instance_variable_get(:@user), "@user of UserConfiguration")
  end

  NAMES = [:name_first, :name_second, :name_third]

  def test_self_names_eq_and_self_names
    UserConfiguration.names = NAMES
    assert_equal(NAMES.sort, UserConfiguration.names.sort, "UserConfiguration.names() after setting one")
  end

  def test_self_names_eq_for_creating_getter_and_setter
    UserConfiguration.names = [:an_attribute]

    uc = UserConfiguration.new(User.create!(name: 'whoever', password: 'whatever'))

    the_value = :the_value_you_never_guess
    uc.an_attribute = the_value
    assert_equal(the_value, uc.an_attribute, "UserConfiguration#an_attribute()")
  end

  def test_user
    user = User.new
    uc = UserConfiguration.new(user)
    assert_equal(user, uc.user, "UserConfiguration.user()")
  end

  def test_user_eq
    user = User.new
    uc = UserConfiguration.new(User.new)
    uc.user = user
    assert_equal(user, uc.instance_variable_get(:@user), "@user of UserConfiguration")
  end

  def test_user_id_eq
    user = User.create!(name: 'whoever', password: 'whatever')
    uc = UserConfiguration.new(User.new)
    uc.user_id = user.id
    assert_equal(user, uc.instance_variable_get(:@user), "@user of UserConfiguration")
  end
end

