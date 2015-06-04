require 'minitest/autorun'
require 'minitest/pride'
require_relative 'keymap'

class KeyMapTester < Minitest::Test

  def test_it_works_for_one_letter
    keymap1 = CharacterMap.new
    value_for_a = keymap1.find_value("a")
    assert_equal 0, value_for_a, "The value of 'a' in the keymap is 0"
  end

  def test_it_works_for_another_letter
    keymap1 = CharacterMap.new
    value_for_b = keymap1.find_value("b")
    assert_equal 1, value_for_b, "The value of 'a' in the keymap is 0"
  end

  def test_it_works_for_comma
    keymap1 = CharacterMap.new
    value_for_comma = keymap1.find_value(",")
    assert_equal 38, value_for_comma, "The value of 'a' in the keymap is 38"
  end
end