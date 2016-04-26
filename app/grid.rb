class Grid < Array

  CONVERT = {
    empty: '.',
    red: '0',
    yellow: '*'
  }
  COLUMN_COUNT = 7
  ROW_COUNT = 6

  def initialize
    super(COLUMN_COUNT) { Array.new(ROW_COUNT,:empty) }
  end

  def add_token column, color
    row = find_next_empty_row column
    self[column][row] = color
  end

  def empty
    map! { Array.new(ROW_COUNT,:empty) }
  end

  def to_s
    rows.reverse.inject('') do |result,row|
      row.each do |value|
        result += CONVERT[value]
      end
      result += "\n"
    end
  end

  def rows
    transpose
  end

  def diagonals grid
    tab = []

    for i in 0...(COLUMN_COUNT - 1 ) do
      tab[i] = []
      count = 0
      for j in (5 - i)..5 do
        tab[i] << grid[count][j]
        count += 1
      end
    end

    for i in 6..11 do
      tab[i] = []
      count = 0
      for j in (i - 5)..6 do
        tab[i] << grid[j][count]
        count += 1
      end
    end
    tab
  end

  def ascending_diagonals
    diagonals self
  end

  def descending_diagonals
    diagonals map(&:reverse)
  end

  private

  def find_next_empty_row column
    self[column].index(:empty)
  end
end