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
    raise IndexError.new if row.nil?
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

    nombre_de_diagonale = COLUMN_COUNT + ROW_COUNT - 1

    for diagonale_number in 0...nombre_de_diagonale do
      tab[diagonale_number] = []
      column_index = 0
      count = 0

      if diagonale_number < 6

        for row_index in (5 - diagonale_number)..5 do
          tab[diagonale_number] << grid[column_index][row_index]
          column_index += 1
        end
      else
        for j in (diagonale_number - 5)..6 do
          tab[diagonale_number] << grid[j][count]
          count += 1
        end
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