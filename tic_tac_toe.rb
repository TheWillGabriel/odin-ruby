# frozen_string_literal: true

# Universal Player methods
class Player
  attr_accessor :name
  attr_reader :piece

  def initialize(name, piece)
    self.name = name
    @piece = piece
  end
end

# Contains methods for creating, setting spaces, and checking state
class Board
  attr_reader :state

  def initialize
    @state = [["", "", ""],
              ["", "", ""],
              ["", "", ""]].freeze
  end

  def get_space(row, column)
    state[row - 1][column - 1]
  rescue StandardError
    puts "#{row},#{column} is not a valid space!"
  end

  # returns false if it fails
  def set_space(row, column, glyph)
    success = false
    unless state[row - 1][column - 1] == ""
      begin
        @state[row - 1][column - 1] = glyph
        success = true
      rescue StandardError
        puts "#{row},#{column} is not a valid space!"
      end
    end
    success
  end

  def full?
    full = true
    state.each do |board_row|
      full = false if board_row.any? { |board_space| board_space == "" }
    end
    full
  end

  def win?(glyph)
    return true if horizontal_line?(glyph) ||
                   vertical_line?(glyph)   ||
                   diagonal_line?(glyph)

    false
  end

  private

  def horizontal_line?(glyph)
    line = false
    state.each do |board_row|
      line = true if board_row.all? { |board_space| board_space == glyph }
    end
    line
  end

  def vertical_line?(glyph)
    line = false
    state.transpose.each do |board_row|
      line = true if board_row.all? { |board_space| board_space == glyph }
    end
    line
  end

  def diagonal_line?(glyph)
    return true if state[0][0] == glyph &&
                   state[1][1] == glyph &&
                   state[2][2] == glyph

    return true if state[0][2] == glyph &&
                   state[1][1] == glyph &&
                   state[2][0] == glyph

    false
  end
end

