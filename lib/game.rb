# frozen_string_literal: true

EMPTY = nil

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
