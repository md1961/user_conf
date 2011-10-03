require 'test_helper'

class UserConfigurationValueAccessorsTest < ActiveSupport::TestCase

  NAME_HOGE  = :hoge
  NAME_ARRAY = :an_array
  NAME_USER  = :user_defined
  NAMES = [NAME_HOGE, NAME_ARRAY, NAME_USER]

  VALUE = 'valuable'

  def setup
    UserConfiguration.names = NAMES

    @user = User.create!(name: 'whoever', password: 'whatever')
    @user.set_conf_value(NAME_HOGE, VALUE)
  end

  def test_set_and_get
    assert_equal(VALUE, @user.get_conf_value(NAME_HOGE), "User#get_conf_value() after set_conf_value()")
  end

  ARRAY = [1, 'two', :three]

  def test_set_and_get_with_an_array
    @user.set_conf_value(NAME_ARRAY, ARRAY)
    assert_equal(ARRAY, @user.get_conf_value(NAME_ARRAY), "User#get_conf_value() with an Array")
  end

  def test_set_and_get_with_a_user_defined_class
    value = UserDefinedClass.new(VALUE)
    @user.set_conf_value(NAME_USER, value)
    actual = @user.get_conf_value(NAME_USER)
    assert_not_nil(actual, "User#get_conf_value() with an UserDefinedClass")
    assert_equal(UserDefinedClass, actual.class, "Class of User#get_conf_value() with an UserDefinedClass")
    assert_equal(VALUE, actual.value, "value of User#get_conf_value() with an UserDefinedClass")
  end

  def test_get_with_unknown_name
    assert_raise(NameError) do
      @user.get_conf_value(:you_never_know_this)
    end
  end

  def test_set_with_different_type
    assert_raise(TypeError) do
      @user.set_conf_value(NAME_HOGE, Object.new)
    end
  end

  class UserDefinedClass
    attr_reader :value

    def initialize(value)
      @value = value
    end
  end
end

