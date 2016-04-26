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
    # tab << [self[0][5]]
    # tab << [self[0][4],self[1][5]]
    # tab << [self[0][3],self[1][4],self[2][5]]
    # tab << [self[0][2],self[1][3],self[2][4],self[3][5]]
    # tab << [self[0][1],self[1][2],self[2][3],self[3][4], self[4][5]]
    # tab << [self[0][0],self[1][1],self[2][2],self[3][3], self[4][4], self[5][5]]

    # tab << [self[1][0],self[2][1],self[3][2],self[4][3], self[5][4], self[6][5]]
    # tab << [self[2][0],self[3][1],self[4][2],self[5][3], self[6][4]]
    # tab << [self[3][0],self[4][1],self[5][2],self[6][3]]
    # tab << [self[4][0],self[5][1],self[6][2]]
    # tab << [self[5][0],self[6][1]]
    # tab << [self[6][0]]
    # tab
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