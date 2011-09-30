require 'test_helper'

class UserConfigurationValueTest < ActiveSupport::TestCase

  NAME  = 'hoge'
  VALUE = 'valuable'

  def setup
    @user      = User.create!(name: :whoever, password: 'whatever')
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
end

