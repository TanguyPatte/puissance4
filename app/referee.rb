require_relative '../app/grid'

class Referee
  attr_reader :current_player

  def initialize
    @grid = Grid.new
    @analyzer = Analyzer.new @grid
    @current_player = :yellow
  end

  def add_token column_number
    check_if_move_is_valid column_number

    @grid.add_token column_number, current_player
    toggle_current_player unless game_ended?

  rescue IndexError
    raise InvalidMoveError.new
  end

  def game_status
    @analyzer.state
  end

  def winner
    @current_player
  end

  private

  def toggle_current_player
    @current_player =  @current_player == :red ? :yellow : :red
  end

  def game_ended?
    @analyzer.state == :won
  end

  def out_of_grid? column_number
    column_number < 0 || column_number > Grid::COLUMN_COUNT
  end

  def check_if_move_is_valid column_number
    raise EndedGameError.new if game_ended?
    raise InvalidMoveError.new if out_of_grid? column_number
  end
end

class InvalidMoveError < Exception
end

class EndedGameError < Exception
end