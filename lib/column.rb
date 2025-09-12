class Column
  HEIGHT = 6

  attr_reader :cells

  # The first element of the cells array represents the bottom of the column
  # while the last element represents the top.
  def initialize(cells = Array.new(HEIGHT) { "(  )" })
    @cells = cells
  end

  def full?
    @cells.all? { |cell| ["(🔴)", "(🔵)"].include?(cell) }
  end

  def empty?
    @cells.none? { |cell| ["(🔴)", "(🔵)"].include?(cell) }
  end

  def drop_token(token)
    return if full?

    index = @cells.index("(  )")
    @cells[index] = "(#{token})"
  end

  def most_recent_token_index
    return if empty?
    return @cells.length - 1 if full?

    @cells.index("(  )") - 1
  end
end
