require 'test_helper'

class UserConfigurationNameTest < ActiveSupport::TestCase

  NAME = 'name1'

  def setup
    @obj_name = UserConfigurationName.new(name: NAME)
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

