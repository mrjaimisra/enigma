require 'minitest/autorun'
require 'minitest/pride'
require_relative 'decrypt'

class DecrypterTester < Minitest::Test

  # acceptance test
  def test_it_decrypts_a_message
    decrypter = Decrypter.new("tseshu3s")
    decrypted_message = decrypter.decrypt
    assert_equal "messages", decrypted_message, "The decrypted message for 'tseshu3s' is 'tseshu3s'"
  end

  def test_it_takes_a_message
    decrypter = Decrypter.new("tseshu3s")
    assert_equal "tseshu3s", decrypter.message, "There should be a message"
  end

  def test_the_message_is_not_nil
    decrypter = Decrypter.new("tseshu3s")
    refute nil
  end

  def test_the_message_has_no_special_characters_or_uppercase_letters
    decrypter = Decrypter.new("12345***#&$(@*$,.striNg ")
    formatted_message = decrypter.format_message
    assert_equal "12345,.string ", formatted_message, "Formatting the message removes special characters and uppercase letters"
  end

  def test_it_splits_the_formatted_message_into_characters
    decrypter = Decrypter.new("tseshu3s")
    message_characters = decrypter.split_message
    assert_equal ["t", "s", "e", "s", "h", "u", "3", "s"], message_characters, "The message characters for 'tseshu3s' should be an array of the letters"
  end

  def test_the_character_map_works
    decrypter = Decrypter.new("tseshu3s")
    character_map = CharacterMap.new.keymap
    assert_equal 0, character_map["a"], "The value for 'a' in the character map should be 0"
  end

  def test_it_finds_the_keymapped_values
    decrypter = Decrypter.new("tseshu3s")
    keymapped_values = decrypter.find_values
    assert_equal [19, 18, 4, 18, 7, 20, 29, 18], keymapped_values, "The keymapped values for 'tseshu3s' should be an array [12, 4, 18, 18, 0, 6, 4, 18]"
  end

  def test_it_collects_the_keymapped_values_into_sets_of_four
    decrypter = Decrypter.new("tseshu3s")
    collected_values = decrypter.collect_values
    assert_equal [[19, 18, 4, 18],[7, 20, 29, 18]], collected_values, "The collected values should be two arrays of four values each [[12, 4, 18, 18],[0, 6, 4, 18]]"
  end

  def test_it_passes_in_the_key_rotation_values_for_each_position
    decrypter = Decrypter.new("tseshu3s")
    rotations = decrypter.pass_in_keys
    assert_equal [01, 12, 23, 34], rotations, "The rotations should be an array of digits in the following order : [A, B, C, D]"
  end

  def test_it_adds_the_rotations_to_the_keymapped_values
    decrypter = Decrypter.new("tseshu3s")
    keymapped_rotated_values = decrypter.rotate
    assert_equal [[18, 6, -19, -16], [6 ,8, 6, -16]], keymapped_rotated_values, "The keymapped_rotated_values should be two arrays of four elements each"
  end

  def test_it_passes_in_the_offsets
    decrypter = Decrypter.new("tseshu3s")
    keymapped_rotated_offset_values = decrypter.offset
    assert_equal [[12, 4, -21, -21], [0, 6, 4, -21]], keymapped_rotated_offset_values, "The keymapped rotated offset values should be arrays of 4 values each"
  end

  def test_it_returns_the_values_to_a_collection
    decrypter = Decrypter.new("tseshu3s")
    recollected_values = decrypter.recollect
    assert_equal [12, 4, -21, -21, 0, 6, 4, -21], recollected_values, "keymapped_rotated_offset_values should be returned as an array where 'A[0], B[0], C[0], D[0], A[1], A[2], A[3], A[4], ...'"
  end

  def test_it_subtracts_39_from_the_decrypted_values_that_are_over_39
    decrypter = Decrypter.new("tseshu3s")
    converted_decrypted_values = decrypter.find_remainder
    assert_equal [12, 4, 18, 18, 0, 6, 4, 18], converted_decrypted_values, "For all numbers greater than 39 it divides the numbers by 39 and replaces them with the remainder"
  end

  def test_it_finds_the_decrypted_characters_in_the_keymap
    decrypter = Decrypter.new("tseshu3s")
    decrypted_characters = decrypter.remap
    assert_equal ["m", "e", "s", "s", "a", "g", "e", "s"], decrypted_characters, "This should be the new collection of decrypted characters"
  end

end