require 'test_helper'

class UserConfigurationNameTest < ActiveSupport::TestCase

  NAME = 'hoge'

  def setup
    @obj_name = UserConfigurationName.new(name: NAME)
  end

  def test_has_many_user_configuration_values_for_emptiness
    assert_equal([], @obj_name.user_configuration_values, "New UserConfigurationName's user_configuration_values")
  end

  def test_has_many_user_configuration_values_for_type_mismatch
    assert_raise(ActiveRecord::AssociationTypeMismatch) do
      @obj_name.user_configuration_values << Object.new
    end
  end

  def test_validates_name_for_uniqueness
    @obj_name.save!

    assert_raise(ActiveRecord::RecordInvalid) do
      UserConfigurationName.create!(name: NAME)
    end

    assert_nothing_raised do
      UserConfigurationName.create!(name: NAME + 'a')
    end
  end

  VALUES = %w(one two three)

  def test_has_many_user_configuration_values
    VALUES.each do |value|
      @obj_name.user_configuration_values << UserConfigurationValue.new(value: value)
    end

    VALUES.each_with_index do |value, index|
      obj_value = @obj_name.user_configuration_values[index]
      assert_not_nil(obj_value, "user_configuration_values[#{index}] should be non-nil")
      assert_equal(value, obj_value.value, "user_configuration_values[#{index}].value")
    end
  end

  def test_equality_operator
    other = UserConfigurationName.new(name: NAME)
    assert(@obj_name == other, "== should be true with a same name")
  end

  def test_equality_operator_for_false
    other = UserConfigurationName.new(name: NAME + 'a')
    assert(@obj_name != other, "== should be false with different names")
  end

  def test_eql_q
    other = UserConfigurationName.new(name: NAME)
    assert(@obj_name.eql?(other), "eql?() should be true with a same name")
  end

  def test_eql_q_for_false
    other = UserConfigurationName.new(name: NAME + 'a')
    assert(! @obj_name.eql?(other), "eql?() should be false with different names")
  end

  def test_hash
    assert_equal(NAME.hash, @obj_name.hash, "UserConfigurationName#hash()")
  end
end

