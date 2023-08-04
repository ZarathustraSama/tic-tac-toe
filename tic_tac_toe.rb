# frozen_string_literal: true

require 'pry-byebug'

X = 'X'
O = 'O'
EMPTY = nil

# The board of the game (3 x 3)
class Grid
  attr_accessor :grid

  def initialize
    @grid = initial_state
  end

  def initial_state
    [[EMPTY, EMPTY, EMPTY], [EMPTY, EMPTY, EMPTY], [EMPTY, EMPTY, EMPTY]]
  end

  def get_current_player(grid)
    if grid == initial_state
      return X
    elsif game_over?(grid)
      return
    end

    x = reduce_grid_x(grid)
    o = reduce_grid_o(grid)
    x > o ? O : X
  end

  def reduce_grid_x(grid)
    x = 0
    grid.each { |row| row.each { |cell| x += 1 if cell == X } }
    x
  end

  def reduce_grid_o(grid)
    o = 0
    grid.each { |row| row.each { |cell| o += 1 if cell == O } }
    o
  end

  def get_winner(grid)
    winner = get_winner_row(grid) || get_winner_column(grid) || get_winner_diagonal(grid)
    return winner if winner

    nil
  end

  def get_winner_row(grid)
    grid.each { |row| return row[0] if row.uniq.count == 1 && row[0] != EMPTY }
    nil
  end

  def get_winner_column(grid)
    grid.each do |row|
      row.each_with_index do |cell, i|
        return cell if [grid[0][i], grid[1][i], grid[2][i]].uniq.count == 1 && i <= 2 && cell != EMPTY
      end
    end
    nil
  end

  def get_winner_diagonal(grid)
    return grid[1][1] if eql_diagonal?(grid) && grid[1][1] != EMPTY

    nil
  end

  def eql_diagonal?(grid)
    left_diagonal = [grid[0][0], grid[1][1], grid[2][2]]
    right_diagonal = [grid[0][2], grid[1][1], grid[2][0]]
    left_diagonal.uniq.count == 1 || right_diagonal.uniq.count == 1
  end

  def game_over?(grid)
    return true if get_winner(grid)
    return false if grid.flatten.any?(nil)

    true
  end

  def make_move(move, grid)
    grid[move[0]][move[1]] = get_current_player(grid)
    self
  end

  def draw_grid(grid)
    puts("\n")
    draw_row(grid[0])
    puts("\n-----------")
    draw_row(grid[1])
    puts("\n-----------")
    draw_row(grid[2])
    puts("\n\n")
  end

  def draw_row(row)
    row_string = ''
    row.each { |cell| row_string += " #{cell || ' '} |" }
    print row_string.chomp!('|')
  end
end

# Where all the logic interaction occurs
class Game
  def ask_user_move(grid)
    loop do
      puts('Choose which row (top, middle, bottom) and which cell (left, center, right)')
      cell_choice = gets.chomp.downcase.split(' ')
      move = convert_grid_index(cell_choice[0], cell_choice[1])
      return move if move && grid[move[0]][move[1]] == EMPTY

      puts('You can\'t do that!')
    end
  end

  def convert_grid_index(row, cell)
    valid_rows = { 'top' => 0, 'middle' => 1, 'bottom' => 2 }
    valid_cells = { 'left' => 0, 'center' => 1, 'right' => 2 }
    return [valid_rows[row], valid_cells[cell]] if valid_rows.include?(row) && valid_cells.include?(cell)

    nil
  end
end

game = Game.new
grid = Grid.new
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
