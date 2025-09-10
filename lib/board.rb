require_relative "column"

class Board
  WIDTH = 7

  attr_reader :columns

  def initialize(columns = Array.new(WIDTH) { Column.new })
    @columns = columns
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
