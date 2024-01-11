# frozen_string_literal: true

require_relative './grid.rb'
require_relative './game.rb'

EMPTY = nil

grid = Grid.new
game = Game.new

loop do
  grid.draw_grid
  game_over = grid.game_over?
  player = grid.get_current_player
  if game_over
    winner = grid.get_winner
    return winner.nil? ? puts('Game Over: It\'s a tie!') : puts("Game Over: #{winner} wins!")
  else
    puts("Player #{player}'s turn")
  end
  grid = grid.make_move(game.ask_user_move(grid.grid))
end
