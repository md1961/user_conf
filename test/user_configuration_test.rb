require 'test_helper'

class UserConfigurationTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(name: 'whoever', password: 'whatever')
  end

  def test_initialize_with_no_user_id
    assert_raise(ArgumentError, "ArgumentError if no :user_id in argument attributes") do
      UserConfiguration.new({})
    end
  end

  UNLIKELY_PERSISTENT_ID = 0

  def test_initialize_with_unknown_user_id
    assert_raise(ArgumentError, "ArgumentError if no User with :user_id in argument attributes") do
      UserConfiguration.new(:user_id => UNLIKELY_PERSISTENT_ID)
    end
  end

  def test_initialize
    uc = UserConfiguration.new(:user_id => @user.id)
    assert_equal(@user, uc.instance_variable_get(:@user), "@user of UserConfiguration")
  end

  NAMES = [:name_first, :name_second, :name_third]

  def test_self_names_eq_and_self_names
    UserConfiguration.names = NAMES
    assert_equal(NAMES.sort, UserConfiguration.names.sort, "UserConfiguration.names() after setting one")
  end

  def test_self_names_eq_for_creating_getter_and_setter
    UserConfiguration.names = [:an_attribute]

    uc = UserConfiguration.new(:user_id => @user.id)

    the_value = :the_value_you_never_guess
    uc.an_attribute = the_value
    assert_equal(the_value, uc.an_attribute, "UserConfiguration#an_attribute()")
  end

  def test_user
    uc = UserConfiguration.new(:user_id => @user.id)
    assert_equal(@user, uc.user, "UserConfiguration.user()")
  end

  def test_user_eq
    uc = UserConfiguration.new(:user_id => @user.id)
    uc.user = @user
    assert_equal(@user, uc.instance_variable_get(:@user), "@user of UserConfiguration")
  end

  def test_user_id_eq
    uc = UserConfiguration.new(:user_id => @user.id)
    uc.user_id = @user.id
    assert_equal(@user, uc.instance_variable_get(:@user), "@user of UserConfiguration")
  end
end

