# frozen_string_literal: true

require_relative '../lib/grid'

describe Grid do
  describe '#get_winner_row' do
    context 'when none has made a full row' do
      subject(:grid_row) { described_class.new([['X', 'O', 'X'], ['X', 'O', 'X'], ['O', 'X', 'O']]) }

      it 'returns nil' do
        expect(grid_row.get_winner_row).to eql(nil)
      end
    end

    context 'when a player has made a full row' do
      subject(:grid_row) { described_class.new([['X', 'X', 'X'], ['O', 'O', nil], [nil, nil, nil]]) }

      it 'returns the player' do
        expect(grid_row.get_winner_row).to eql('X')
      end
    end
  end

  describe '#get_winner_column' do
    context 'when none has made a full column' do
      subject(:grid_column) { described_class.new([['X', 'O', 'X'], ['X', 'O', 'X'], ['O', 'X', 'O']]) }

      it 'returns nil' do
        expect(grid_column.get_winner_column).to eql(nil)
      end
    end

    context 'when a player has made a full column' do
      subject(:grid_column) { described_class.new([['X', 'O', nil], ['X', 'O', nil], ['X', nil, nil]]) }

      it 'returns the player' do
        expect(grid_column.get_winner_column).to eql('X')
      end
    end
  end

  describe '#get_winner_diagonal' do
    context 'when none has made a full diagonal' do
      subject(:grid_diagonal) { described_class.new([['X', 'O', nil], ['X', 'O', nil], ['X', nil, nil]]) }

      it 'returns nil' do
        expect(grid_diagonal.get_winner_diagonal).to eql(nil)
      end
    end

    context 'when a player has made a full diagonal' do
      subject(:grid_diagonal) { described_class.new([['X', 'O', 'nil'], ['O', 'X', nil], [nil, nil, 'X']]) }

      it 'returns the player' do
        expect(grid_diagonal.get_winner_diagonal).to eql('X')
      end
    end
  end

  describe '#game_over?' do
    context 'when there is a winner' do
      subject(:grid_over) { described_class.new([['X', 'X', 'X'], [nil, nil, nil], [nil, nil, nil]]) }

      it 'returns true' do
        expect(grid_over).to be_game_over
      end
    end

    context 'when there are still moves left' do
      subject(:grid_not_over) { described_class.new }

      it 'returns false' do
        expect(grid_not_over).not_to be_game_over
      end
    end

    context 'when there are no possible moves left' do
      subject(:grid_over) { described_class.new([['X', 'O', 'X'], ['X', 'O', 'X'], ['O', 'X', 'O']]) }

      it 'returns true' do
        expect(grid_over).to be_game_over
      end
    end
  end

  describe '#reduce_grid' do
    context 'at the beginning of the game' do
      subject(:grid_start) { described_class.new }

      it 'returns 0' do
        expect(grid_start.reduce_grid('X')).to eql(0)
      end
    end

    context 'when there are 3 "X" and 4 "O"' do
      subject(:grid_mid) { described_class.new([['X', 'O', 'X'], ['X', 'O', 'O'], ['O', nil, nil]]) }

      it 'returns 3 when asked for X' do
        expect(grid_mid.reduce_grid('X')).to eql(3)
      end

      it 'returns 4 when asked for O' do
        expect(grid_mid.reduce_grid('O')).to eql(4)
      end
    end
  end

  describe '#get_current_player' do
    context 'at the beginning of the game' do
      subject(:grid_start) { described_class.new }

      it 'returns X' do
        expect(grid_start.get_current_player).to eql('X')
      end
    end

    context 'when the game is over' do
      subject(:grid_end) { described_class.new([['X', 'X', 'X'], ['O', 'O', nil], [nil, nil, nil]]) }

      it 'returns with no value' do
        expect(grid_end.get_current_player).to eql(nil)
      end
    end

    context 'when the game is not over' do
      subject(:grid_play) { described_class.new([['X', 'O', 'X' ], [nil, nil, nil], [nil, nil, nil]]) }

      it 'returns the correct next player' do
        expect(grid_play.get_current_player).to eql('O')
      end
    end
  end
end
