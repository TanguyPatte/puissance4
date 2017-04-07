require_relative '../app/grid'
require_relative '../app/referee'
require_relative '../app/analyzer'

class Application

  def initialize
    @referee = Referee.new
  end

  def run
    while !game_ended? do
      puts `clear`
      display_grid
      display_player
      ask_and_play_move
    end
    display_winner
  end

  def display_grid
    puts @referee.render
  end

  def display_player
    puts "Un nouveau joueur approche: " + current_player_name
  end

  def ask_and_play_move
    @referee.add_token gets.to_i
  rescue InvalidMoveError
    puts 'Oups, cette proposition est invalide (NOOB!)'
    ask_and_play_move
  end

  def ask_input
    number = gets
    number.match(/[0-9]/) ? number.to_i : -1
  end

  def display_winner
    if @referee.game_status == :won
      puts 'And the winner is: ' + current_player_name
    else
      puts 'All loosers'
    end
  end

  def game_ended?
    [:won, :draw].include? @referee.game_status
  end

  private

  PLAYER_NAMES = { red: "ROUGE", yellow: "JAUNE" }

  def current_player_name
    PLAYER_NAMES[@referee.current_player]
  end
end
