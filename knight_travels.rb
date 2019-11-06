# frozen_string_literal: true

class Chessboard
  class Knight
    attr_accessor :pos
    attr_reader :moves
    def initialize(pos = nil)
      @moves = [[-2, 1], [-1, 2], [1, 2], [2, 1],
                [-2, -1], [-1, -2], [1, -2], [2 - 1]]
      @pos = pos
    end
  end

  attr_accessor :start, :finish

  def initialize(start, finish)
    @knight = Knight.new(start)
    @start = start
    @finish = finish
  end

  def valid?(pos, move)
    return false unless @knight.moves.include? move

    (pos[0] + move[0]).between?(0, 7) && (pos[1] + move[1]).between?(0, 7)
  end

  def exists?(space)
    space[0].between?(0, 7) && space[1].between?(0, 7)
  end

  def try(pos, move)
    result = [pos[0] + move[0], pos[1] + move[1]]
    result.exists? ? result : nil
  end

  def knight_moves(start = @start, finish = @finish)
    return nil unless start.exists? && finish.exists?

    @knight.moves.each do |move|

    end
  end
end
