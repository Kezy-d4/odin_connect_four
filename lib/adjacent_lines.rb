require_relative "board"
require_relative "column"

class AdjacentLines
  def initialize(cell_coordinates)
    @cell_coordinates = cell_coordinates
  end

  def select_in_bounds_lines
    lines.select do |line|
      line.all? do |coordinates|
        valid_coordinates?(coordinates)
      end
    end
  end

  private

  def valid_coordinates?(coordinates)
    x = coordinates.first
    y = coordinates.last
    x.between?(0, Board::WIDTH - 1) && y.between?(0, Column::HEIGHT - 1)
  end

  def lines
    [bottom_vertical, top_vertical, left_horizontal, right_horizontal,
     bottom_left_diagonal, top_right_diagonal, top_left_diagonal,
     bottom_right_diagonal]
  end

  def x_coordinate
    @cell_coordinates.first
  end

  def y_coordinate
    @cell_coordinates.last
  end

  # The cell coordinates being evaluated are implicit in each of the following
  # lines.
  def bottom_vertical
    [[x_coordinate, y_coordinate - 1],
     [x_coordinate, y_coordinate - 2],
     [x_coordinate, y_coordinate - 3]]
  end

  def top_vertical
    [[x_coordinate, y_coordinate + 1],
     [x_coordinate, y_coordinate + 2],
     [x_coordinate, y_coordinate + 3]]
  end

  def left_horizontal
    [[x_coordinate - 1, y_coordinate],
     [x_coordinate - 2, y_coordinate],
     [x_coordinate - 3, y_coordinate]]
  end

  def right_horizontal
    [[x_coordinate + 1, y_coordinate],
     [x_coordinate + 2, y_coordinate],
     [x_coordinate + 3, y_coordinate]]
  end

  def bottom_left_diagonal
    [[x_coordinate - 1, y_coordinate - 1],
     [x_coordinate - 2, y_coordinate - 2],
     [x_coordinate - 3, y_coordinate - 3]]
  end

  def top_right_diagonal
    [[x_coordinate + 1, y_coordinate + 1],
     [x_coordinate + 2, y_coordinate + 2],
     [x_coordinate + 3, y_coordinate + 3]]
  end

  def top_left_diagonal
    [[x_coordinate - 1, y_coordinate + 1],
     [x_coordinate - 2, y_coordinate + 2],
     [x_coordinate - 3, y_coordinate + 3]]
  end

  def bottom_right_diagonal
    [[x_coordinate + 1, y_coordinate - 1],
     [x_coordinate + 2, y_coordinate - 2],
     [x_coordinate + 3, y_coordinate - 3]]
  end
end
