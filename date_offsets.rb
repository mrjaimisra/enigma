require 'pry'
require 'time'

class DateOffset
  attr_reader :date

  def initialize(date=Time.new.strftime("%m%d%y"))
    @date = date
  end

  def square_date
    (@date.to_i**2).to_s
  end

  def find_offsets
    square_date[-4..-1].chars.map {|digit| digit.to_i}
  end
end