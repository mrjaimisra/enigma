require 'minitest/autorun'
require 'minitest/pride'
require_relative 'key_generator'

class KeyGeneratorTester < Minitest::Test
#   acceptance test
#   can I put @key in initialize and replace the key = Key.new statements?

  def test_it_accepts_a_key_as_input
    key = Key.new("01234")
    assert_equal "01234", key.key, "The key should be the input"
  end

  def test_if_no_input_is_given_then_randomize_a_key
    key = Key.new(99999)
    random_key = key.randomize.to_s.length
    assert_equal 5, random_key, "The random key should be five digits long"
  end

  def test_it_splits_the_key_into_digits
    key = Key.new("01234")
    key_in_digits = key.split_into_digits
    assert_equal ["0", "1", "2", "3", "4"], key_in_digits, "The key should be an array of five digits in string format"
  end

  def test_it_uses_the_key_in_digits_to_find_the_rotations
    key = Key.new("01234")
    rotations = key.find_rotations
    assert_equal ["01", "12", "23", "34"], rotations, "The rotation for position A is 'digits[01]', B is 'digits[12]', C is 'digits[23]', D is 'digits[34]', converted from strings to numbers"
  end
end