require 'test_helper'

class UserConfigurationValueAccessorsTest < ActiveSupport::TestCase

  NAME  = :hoge
  VALUE = 'valuable'

  def setup
    @user = User.create!(name: 'whoever', password: 'whatever')
  end

  def test_set_and_get
    @user.set_conf_value(NAME, VALUE)
    assert_equal(VALUE, @user.get_conf_value(NAME), "User#get_conf_value() after set_conf_value()")
  end
end

