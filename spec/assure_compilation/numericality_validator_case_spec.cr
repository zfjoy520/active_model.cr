require "../../src/*"

class CrazyNumbers
  include ActiveModel

  setter :floaty, :inty, :more_than_zero, :zero_or_more, :zero_only,
    :less_than_zero, :zero_or_less, :odd_only, :even_only, :not_zero

  @floaty :: Float64?
  @inty :: Int64 | Int32 | Int16 | Int8 | Nil
  @more_than_zero :: Int64 | Int32 | Int16 | Int8 | Nil
  @zero_or_more :: Int64 | Int32 | Int16 | Int8 | Nil
  @zero_only :: Int64 | Int32 | Int16 | Int8 | Nil
  @less_than_zero :: Int64 | Int32 | Int16 | Int8 | Nil
  @zero_or_less :: Int64 | Int32 | Int16 | Int8 | Nil
  @odd_only :: Int64 | Int32 | Int16 | Int8 | Nil
  @even_only :: Int64 | Int32 | Int16 | Int8 | Nil
  @not_zero :: Int64 | Int32 | Int16 | Int8 | Nil

  validates :floaty, { numericality: true } # is a number
  validates :inty, { numericality: { only_integer: true } } # is an integer
  validates :more_than_zero, { numericality: { greater_than: 0 } } # > other number
  validates :zero_or_more, { numericality: { greater_than_or_equal_to: 0 } } # >= other number
  validates :zero_only, { numericality: { equal_to: 0 } } # == other number
  validates :less_than_zero, { numericality: { less_than: 0 } } # < other number
  validates :zero_or_less, { numericality: { less_than_or_equal_to: 0 } } # <= other number
  validates :odd_only, { numericality: { odd: true } } # is odd
  validates :even_only, { numericality: { even: true } } # is even
  validates :not_zero, { numericality: { other_than: 0 } } # != other number
end

describe CrazyNumbers do
  it "accepts valid attributes" do
    numbers = CrazyNumbers.new
    numbers.floaty = nil
    numbers.inty = nil
    numbers.more_than_zero = 0
    numbers.zero_or_more = -1
    numbers.zero_only = 1
    numbers.less_than_zero = 0
    numbers.zero_or_less = 1
    numbers.odd_only = 2
    numbers.even_only = 1
    numbers.not_zero = 0
    numbers.valid?.should be_false
  end

  it "accepts invalid attributes" do
    numbers = CrazyNumbers.new
    numbers.floaty = 3.14
    numbers.inty = 3
    numbers.more_than_zero = 1
    numbers.zero_or_more = 0
    numbers.zero_only = 0
    numbers.less_than_zero = -1
    numbers.zero_or_less = 0
    numbers.odd_only = 1
    numbers.even_only = 2
    numbers.not_zero = 418
    numbers.valid?.should be_true
  end
end