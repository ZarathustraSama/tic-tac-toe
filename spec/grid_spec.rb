# frozen_string_literal: true

require_relative '../lib/grid.rb'

describe Grid do
  describe '#reduce_grid' do

    context 'at the beginning of the game' do
      subject(:grid_start) { described_class.new }

      it 'returns 0' do
        expect(grid_start.reduce_grid(player_x)).to eql(0)
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
    
  end


end