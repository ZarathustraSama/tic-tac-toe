# frozen_string_literal: true

require_relative '../lib/grid.rb'

describe Grid do
  describe '#reduce_grid' do
    let(:player_x) { 'X' }
    let(:player_o) { 'O' }

    context 'at the beginning of the game' do
      subject(:grid_start) { described_class.new }

      it 'returns 0' do
        expect(grid_start.reduce_grid(player_x)).to eql(0)
      end
    end
  end

end