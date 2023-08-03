# frozen_string_literal: true

X = 'X'
O = 'O'
EMPTY = nil

# The board of the game (3 x 3)
class Grid
  attr_accessor :grid

  def initialize
    @grid = initial_state
  end

  private

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
    get_winner_row(grid) || get_winner_column || get_winner_diagonal
    nil
  end

  def get_winner_row(grid)
    grid.each { |row| return row[0] if row.uniq.count == 1 && row[0] != EMPTY }
    nil
  end

  def get_winner_column(grid)
    grid.each.each_with_index do |cell, i|
      return cell if [grid[0][i], grid[1][i], grid[2][i]].uniq.count == 1 && i <= 2 && cell != EMPTY
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

  def draw_grid(grid)
    draw_row(grid[0])
    puts('------')
    draw_row(grid[1])
    puts('------')
    draw_row(grid[2])
  end

  def draw_row(row)
    row.each { |cell| puts("#{cell || ' '} | ") }
  end
end

# Where all the logic interaction occurs
class Game
  def initialize
    @grid = Grid.new
  end

  private

  def make_move
    move = ask_user_move
    @grid[move[0]][move[1]] = @current_player
  end

  def ask_user_move
    loop do
      row_choice = prompt('Choose which row (top, middle, bottom)').downcase
      cell_choice = prompt('Choose which cell (left, center, right)').downcase
      move = convert_grid_index(row_choice, cell_choice)
      return move if move && @grid[move[0]][move[1]] == EMPTY

      puts('You can\'t do that!')
    end
  end

  def convert_grid_index(row, cell)
    valid_rows = { top: 0, middle: 1, bottom: 2 }
    valid_cells = { left: 0, center: 1, right: 2 }
    return [valid_rows[row], valid_cells[cell]] if valid_rows.include?(row) && valid_cells.include?(cell)

    nil
  end
end

game = Game.new
grid = game.grid
loop do
  grid.draw_grid
  game_over = grid.game_over?(grid)
  player = grid.get_current_player(grid)
  if game_over
    winner = grid.get_winner
    winner.nil? ? puts('Game Over: It\'s a tie!') : puts("Game Over: #{winner} wins!")
  else
    puts("Player #{player}'s turn")
  end
  game.make_move
end
