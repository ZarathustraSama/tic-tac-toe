# frozen_string_literal: true

X = 'X'
O = 'O'
EMPTY = nil

# The board of the game (3 x 3)
class Grid
  attr_accessor :grid

  def initialize(grid = initial_state)
    @grid = grid
  end

  def get_current_player(grid)
    if grid == initial_state
      return X
    elsif game_over?(grid)
      return
    end

    reduce_grid(grid, X) > reduce_grid(grid, O) ? O : X
  end
      
  # Helper function to check how many x/o are in the grid
  def reduce_grid(grid, player)
    i = 0
    grid.each { |row| row.each { |cell| i += 1 if cell == player } }
    i
  end

  def get_winner(grid)
    winner = get_winner_row(grid) || get_winner_column(grid) || get_winner_diagonal(grid)
    return winner if winner

    nil
  end

  # After the game over, checks for rows, columns and diagonals
  # If none won, returns nil (it's a tie)
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

  private

  # The initial state of a classic 3 by 3 board
  def initial_state
    [[EMPTY, EMPTY, EMPTY], [EMPTY, EMPTY, EMPTY], [EMPTY, EMPTY, EMPTY]]
  end

  # Helper function for drawing a row with cells
  def draw_row(row)
    row_string = ''
    row.each { |cell| row_string += " #{cell || ' '} |" }
    print row_string.chomp!('|')
  end
end