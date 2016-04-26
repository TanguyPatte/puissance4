class Analyzer

  def initialize grid
    @grid = grid
  end

  def state
    return :won if alignments.any? do |lines|
      winning_line? lines
    end

    return :draw if @grid.none? do |column|
      column.include? :empty
    end

    :running
  end

  private

  def alignments
    [@grid, @grid.rows, @grid.ascending_diagonals, @grid.descending_diagonals]
  end

  def winning_line? lines
    lines.any? do |line|
      four_in_a_row? line
    end
  end

  def four_in_a_row? line
    line.each_cons(4).any? do |stack|
      stack.uniq.size == 1 && stack[0] != :empty
    end
  end
end