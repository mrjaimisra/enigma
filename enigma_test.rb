require 'minitest/autorun'
require 'minitest/pride'
require_relative 'enigma'

class EncrypterTester < Minitest::Test
  # acceptance test

  def test_it_encrypts_a_message
    encrypter = Encrypter.new("messages")
    encrypted_message = encrypter.encrypt
    assert_equal "tseshu3s", encrypted_message, "The encrypted message for 'messages' is 'tseshu3s'"
  end

  def test_it_takes_a_message
    encrypter = Encrypter.new("messages")
    assert_equal "messages", encrypter.message, "There should be a message"
  end

  def test_the_message_is_not_nil
    encrypter = Encrypter.new("messages")
    refute nil
  end

  def test_the_message_has_no_special_characters_or_uppercase_letters
    encrypter = Encrypter.new("12345***#&$(@*$,.striNg ")
    formatted_message = encrypter.format_message
    assert_equal "12345,.string ", formatted_message, "Formatting the message removes special characters and uppercase letters"
  end

  def test_it_splits_the_formatted_message_into_characters
    encrypter = Encrypter.new("messages")
    message_characters = encrypter.split_message
    assert_equal ["m", "e", "s", "s", "a", "g", "e", "s"], message_characters, "The message characters for 'message' should be an array of the letters"
  end

  def test_the_character_map_works
    encrypter = Encrypter.new("messages")
    character_map = CharacterMap.new.keymap
    assert_equal 0, character_map["a"], "The value for 'a' in the character map should be 0"
  end

  def test_it_finds_the_keymapped_values
    encrypter = Encrypter.new("messages")
    keymapped_values = encrypter.find_values
    assert_equal [12, 4, 18, 18, 0, 6, 4, 18], keymapped_values, "The keymapped values for 'messages' should be an array [12, 4, 18, 18, 0, 6, 4, 18]"
  end

  def test_it_collects_the_keymapped_values_into_sets_of_four
    encrypter = Encrypter.new("messages")
    collected_values = encrypter.collect_values
    assert_equal [[12, 4, 18, 18],[0, 6, 4, 18]], collected_values, "The collected values should be two arrays of four values each [[12, 4, 18, 18],[0, 6, 4, 18]]"
  end

  def test_it_passes_in_the_key_rotation_values_for_each_position
    encrypter = Encrypter.new("messages")
    rotations = encrypter.pass_in_keys
    assert_equal [01, 12, 23, 34], rotations, "The rotations should be an array of digits in the following order : [A, B, C, D]"
  end

  def test_it_adds_the_rotations_to_the_keymapped_values
    encrypter = Encrypter.new("messages")
    keymapped_rotated_values = encrypter.rotate
    assert_equal [[13, 16, 41, 52], [1, 18, 27, 52]], keymapped_rotated_values, "The keymapped rotated values should be two arrays"
  end

  def test_it_passes_in_the_offsets
    encrypter = Encrypter.new("messages")
    keymapped_rotated_offset_values = encrypter.offset
    assert_equal [[19, 18, 43, 57], [7, 20, 29, 57]], keymapped_rotated_offset_values, "The keymapped rotated values plus the offset for the corresponding position"
  end

  def test_it_returns_the_values_to_a_collection
    encrypter = Encrypter.new("messages")
    recollected_values = encrypter.recollect
    assert_equal [19, 18, 43, 57, 7, 20, 29, 57], recollected_values, "The keymapped_rotated_offset_values should be returned as an array where 'A[0], B[0], C[0], D[0], A[1], A[2], A[3], A[4], ...'"
  end

  def test_it_subtracts_39_from_the_encrypted_values_that_are_over_39
    encrypter = Encrypter.new("messages")
    converted_encrypted_values = encrypter.find_remainder
    assert_equal [19, 18, 4, 18, 7, 20, 29, 18], converted_encrypted_values, "For all numbers greater than 39 it divides the numbers by 39 and replaces them with the remainder"
  end

  def test_it_finds_the_encrypted_characters_in_the_keymap
    encrypter = Encrypter.new("messages")
    encrypted_characters = encrypter.remap
    assert_equal ["t", "s", "e", "s", "h", "u", "3", "s"], encrypted_characters, "This should be the new collection of encrypted characters"
  end
end

