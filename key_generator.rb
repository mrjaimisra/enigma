# INPUT/GENERATE THE KEY AND FIND THE ROTATIONS:

# 6. Take in a key as input (ex. 01234)
# 7. if no key is input, set the default key to a random five digit string
# 7. Split key into digits (ex. [0, 1, 2, 3, 4])
# 8. Use digits to calculate rotations
#                     [01, 12, 23, 34] =
# for positions    [A, B, C, D]

class Key
  attr_reader :key
              :rotations

  def initialize(key="99999")
    @key = key
  end

  def randomize
    if @key == "99999"
    @key = rand(99999).to_s.rjust(5, '0')
    else
      @key
    end

  end

  def split_into_digits
    randomize.chars
  end

  def find_rotations
    @rotations = []
    split_into_digits.map.with_index do |digit, index|
      @rotations << "#{split_into_digits[index]}#{split_into_digits[index+1]}"
    end
    @rotations.pop
    @rotations
  end

end