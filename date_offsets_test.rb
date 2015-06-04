require 'minitest/autorun'
require 'minitest/pride'
require_relative 'date_offsets'

class DateOffsetTester < Minitest::Test

  def test_it_defaults_to_the_current_date
    date1 = DateOffset.new()
    current_date = date1.date # Date class in ruby must have a method to replace
    assert_equal "060415", current_date, "The current date should be today's date"
  end

  def test_it_accepts_a_date_as_an_input
    date1 = DateOffset.new("050487")
    other_date = date1.date
    assert_equal "050487", other_date, "The date should equal the input date, not the current date."
  end

  def test_it_squares_the_numerical_date
    date = DateOffset.new("060215")
    squared_date = date.square_date
    assert_equal "3625846225", squared_date, "The square of 060315 is 3625846225"
  end

  def test_it_maps_the_last_four_digits_into_a_collection
    date = DateOffset.new("060215")
    offsets = date.find_offsets
    assert_equal [6, 2, 2, 5], offsets, "Split the last four digits into a collection where each digit's position maps to offsets A, B, C, D"
  end
end

