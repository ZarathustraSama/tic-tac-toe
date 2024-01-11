# frozen_string_literal: true

require './grid.rb'
require './game.rb'

EMPTY = nil
grid = Grid.new
game = Game.new

loop do
  grid.draw_grid(grid.grid)
  game_over = grid.game_over?(grid.grid)
  player = grid.get_current_player(grid.grid)
  if game_over
    winner = grid.get_winner(grid.grid)
    return winner.nil? ? puts('Game Over: It\'s a tie!') : puts("Game Over: #{winner} wins!")
  else
    puts("Player #{player}'s turn")
  end
  grid = grid.make_move(game.ask_user_move(grid.grid), grid.grid)
end
