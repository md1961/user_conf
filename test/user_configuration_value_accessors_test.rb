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

  def test_get_with_unknown_name
    assert_raise(NameError) do
      @user.get_conf_value(:you_never_know)
    end
  end
end

