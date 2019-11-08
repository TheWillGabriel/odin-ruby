# Stores and processes board level and logic
class Board
  attr_reader :grid

  def initialize
    @width = 7
    @height = 6
    @grid = Array.new(@height) { Array.new(@width) }
  end

  def add(column, player)
    return nil unless column.between?(0, 6)

    @grid.each_index do |row|
      next unless @grid[row][column].nil?

      @grid[row][column] = player
      return [row, column]
    end
    nil
  end

  def full?
    @grid[5].each do |column|
      return false if column.nil?
    end
    true
  end

  def line?(row, column)
    horizontal_line?(row, column) || vertical_line?(row, column)
  end

  private

    def horizontal_line?(row, column)
      left_matches(row, column) + right_matches(row, column) >= 3
    end

    def vertical_line?(row, column)
      false if row < 3

      line = @grid.transpose[column][0..row]
      matching_value = @grid[row][column]
      matches = 0
      line.reverse.each do |space|
        break unless space == matching_value

        matches += 1
      end
      matches >= 4
    end

    def left_matches(row, column)
      line = @grid[row][0..column]
      matching_value = @grid[row][column]
      matches = -1
      line.reverse.each do |space|
        break unless space == matching_value

        matches += 1
      end
      matches
    end

    def right_matches(row, column)
      line = @grid[row][column..-1]
      matching_value = @grid[row][column]
      matches = -1
      line.each do |space|
        break unless space == matching_value

        matches += 1
      end
      matches
    end
end
