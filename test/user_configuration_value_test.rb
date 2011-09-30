require 'test_helper'

class UserConfigurationValueTest < ActiveSupport::TestCase

  VALUE = 'hoge'
  NAME_ID = 0

  def setup
    @obj_value = UserConfigurationValue.new(user_configuration_name_id: NAME_ID, value: VALUE)
  end

  def test_belongs_to_user
    user = User.create!(name: :whoever, password: 'whatever')
    user.user_configuration_values << @obj_value
    assert_equal(user, @obj_value.user, "User whom the UserConfigurationValue belongs to")
  end
end

