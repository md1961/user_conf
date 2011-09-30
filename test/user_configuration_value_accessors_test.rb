require 'test_helper'

class UserConfigurationValueAccessorsTest < ActiveSupport::TestCase

  NAME  = :hoge
  VALUE = 'valuable'

  def setup
    @user = User.create!(name: 'whoever', password: 'whatever')
    @user.set_conf_value(NAME, VALUE)
  end

  def test_set_and_get
    assert_equal(VALUE, @user.get_conf_value(NAME), "User#get_conf_value() after set_conf_value()")
  end

  ARRAY = [1, 'two', :three]

  def test_set_and_get_with_an_array
    name = :an_array
    @user.set_conf_value(name, ARRAY)
    assert_equal(ARRAY, @user.get_conf_value(name), "User#get_conf_value() after set_conf_value() with an Array")
  end

  def test_get_with_unknown_name
    assert_raise(NameError) do
      @user.get_conf_value(:you_never_know_this)
    end
  end
end

