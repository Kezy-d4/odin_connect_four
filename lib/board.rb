require_relative "column"
require_relative "adjacent_lines"

# Represents a Connect Four board
class Board
  WIDTH = 7

  attr_reader :columns

  def initialize(columns = Array.new(WIDTH) { Column.new })
    @columns = columns
  end

  def any_winning_line?(token, cell_coordinates)
    AdjacentLines.new(cell_coordinates).select_in_bounds_lines.any? do |line|
      line.all? do |coordinates|
        x = coordinates.first
        y = coordinates.last
        cell = @columns[x].cells[y]
        cell == "(#{token})"
      end
    end
  end

  def full?
    @columns.all?(&:full?)
  end

  def column_available?(index)
    !@columns[index].full?
  end

  def drop_token_in_column(column_index, token)
    @columns[column_index].drop_token(token)
  end

  def most_recent_token_coordinates(column_index)
    return if @columns[column_index].empty?

    x_coordinate = column_index
    y_coordinate = @columns[column_index].most_recent_token_index
    [x_coordinate, y_coordinate]
  end

  def render
    (1..WIDTH).each { |int| print "  #{int}  " }
    puts

    Column::HEIGHT.times do |index|
      @columns.each do |column|
        print "#{column.cells[-(index + 1)]} "
      end
      2.times { puts }
    end
  end
end
