class Analyzer

  def initialize grid
    @grid = grid
  end

  def state
    return :won if [@grid, @grid.rows, @grid.ascending_diagonals, @grid.descending_diagonals].any? do |lines|
      winning_line? lines
    end

    return :null if @grid.none? do |column|
      column.include? :empty
    end

    :running
  end

  private

  def winning_line? lines
    lines.any? do |line|
      four_in_a_row? line
    end
  end

  def four_in_a_row? row
    row.each_cons(4) do |tab|
      return true if tab.uniq.size == 1 && tab[0] != :empty
    end
    false
  end
end