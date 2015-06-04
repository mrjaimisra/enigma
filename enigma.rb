require 'pry'
require_relative 'keymap'
require_relative 'key_generator'
require_relative 'date_offsets'


class Encrypter
  attr_accessor :message

  def initialize(message)
    @message = message
  end

  def encrypt
    remap.join
  end

  def format_message
    formatted_message = @message.gsub(/[^[a-zA-Z][\d] ,.]/,'')
    formatted_message.downcase
  end

  def split_message
    format_message.split("")
  end

  def find_values
    character_map = CharacterMap.new.keymap
    split_message.map do |character|
        character_map[character]
    end
  end

  def collect_values
    collected_values = []
    find_values.each_slice(4) {|slice| collected_values << slice}
    collected_values
  end

  def pass_in_keys
    rotations = Key.new("01234").find_rotations
    rotations.map {|rotation| rotation.to_i}
  end

  def rotate
    rotated_values = [] # I need to figure out what goes here
    collect_values.map do |element|
      rotated_values << element.map.with_index do |char, index|
        char + pass_in_keys[index]
      end
    end
    rotated_values
  end

  def pass_in_offsets
    offsets = DateOffset.new("060215").find_offsets
    offsets.map {|offset| offset.to_i}
  end

  def offset
    offset_values = []
    rotate.map do |element|
      offset_values << element.map.with_index do |char, index|
        char + pass_in_offsets[index]
      end
    end
    offset_values
  end

  def recollect
    offset.flatten
  end

  def find_remainder
    encrypted_values = []
    recollect.map {|value| encrypted_values << value.modulo(39)}
    encrypted_values
  end

  def remap
    encrypted_characters = CharacterMap.new.keymap
    find_remainder.map do |character|
      encrypted_characters.invert[character]
    end
  end

end

enigma = Encrypter.new("messages")
p "this is the formatted message: #{enigma.format_message.inspect}"
p "this is the split message #{enigma.split_message.inspect}"
p "these are the values in the character map #{enigma.find_values.inspect}"
p "these are the collected values from the character map #{enigma.collect_values.inspect}"
p "these are the keys #{enigma.pass_in_keys.inspect}"
p "these are the rotated values #{enigma.rotate.inspect}"
p "these are the offsets #{enigma.pass_in_offsets.inspect}"
p "these are the offset values #{enigma.offset.inspect}"
p "these are the recollected values after being rotated and offset #{enigma.recollect.inspect}"
p "these are the new values to be keymapped #{enigma.find_remainder.inspect}"
p "these are the new character mapped values #{enigma.remap.inspect}"
p "this is the new encrypted message #{enigma.encrypt.inspect}"

# Encrypter Steps (Pseudocode):

# MAP THE MESSAGE TO THE CHARACTER MAP:

# 1. Take in a message as input
#    -message should have no special characters
#    -all messages should be in lowercase letters
# message.gsub!(/[^abcdefghijklmnopqurstuvwxyz0123456789 ,.]/,'')

# 2. Split message into characters
# 3. Find the keymap values (cypher)
# 4. Collect the keymapped values into sets of four
# 5. Assign positions (0,1,2,3) in each set to a corresponding letter
#                     A = 0
#                     B = 1
#                     C = 2
#                     D = 3
# 6. Pass in the rotations so they can be added to each position
# 7. Add the rotations to the keymapped values
# 8. Pass in the offsets so they can be added to each position
# 9. Add the offsets to the rotated keymapped values
# 10. Return the
# 11. For all rotated_keymapped_offset values > 39, subtract 39
#                     rotated_keymapped_offset_values_modulo(39)
# 12. For all rotated_keymapped_offset_values_modulo(39), find the new_keymapped_values
# 13. Collect the new_keymapped_values into a single string
# 14. Print the encrypted message

# OFFSET THE MESSAGE:
# (Date class...)

# 1. The default value is the current date
# 2. If an input is given, it must be in the form "######"
       # remove all special characters and spaces
       # no uppercase or lowercase letters
# 3. Square the numerical date
#                     060215 ^ 2 = 3625846225
# 4. Take the last four digits of the squared date (6225)
# 5. Split them into a collection of digits [6, 2, 2, 5]
# 6. Assign each digit to a corresponding position
#                     A = 6
#                     B = 2
#                     C = 2
#                     D = 5


# DECRYPT

# . make it so it can instantiate with today's date as the default,
# . but if you pass in another date it calculates the offsets

# COMMAND LINE : make it work for encrypt and decrypt