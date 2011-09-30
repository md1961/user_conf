require 'test_helper'

class UserConfigurationValueTest < ActiveSupport::TestCase

  NAME  = 'hoge'
  VALUE = 'valuable'

  def setup
    @user      = User.create!(name: 'whoever', password: 'whatever')
    @obj_name  = UserConfigurationName.create!(name: NAME)
    @obj_value = UserConfigurationValue.new(user_configuration_name: @obj_name, value: VALUE)
  end

  def test_belongs_to_user
    @user.user_configuration_values << @obj_value
    assert_equal(@user, @obj_value.user, "User whom the UserConfigurationValue belongs to")
  end

  def test_validates_user_configuration_name_id_for_uniqueness
    @user.user_configuration_values << @obj_value
    assert_raise(ActiveRecord::RecordInvalid) do
      @user.user_configuration_values.create!(user_configuration_name: @obj_name, value: VALUE)
    end
  end

  def test_validates_user_configuration_name_id_for_uniqueness_to_pass
    @user.user_configuration_values << @obj_value

    obj_name2 = UserConfigurationName.create!(name: NAME + '2')
    assert_nothing_raised("Same user and different name should pass validation") do
      @user.user_configuration_values.create!(user_configuration_name: obj_name2, value: VALUE)
    end

    user2 = User.create!(name: 'whoever2', password: 'whatever')
    assert_nothing_raised("Same name and different user should pass validation") do
      user2.user_configuration_values.create!(user_configuration_name: @obj_name, value: VALUE)
    end
  end
end

