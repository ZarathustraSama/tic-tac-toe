# frozen_string_literal: true

require_relative '../lib/game'

describe Game do
  describe '#convert_grid_index' do
    subject(:game) { described_class.new }

    context 'when the input is invalid' do
      let(:invalid_row) { 'fafefrgggea' }
      let(:invalid_cell) { 2332 }

      it 'returns nil' do
        expect(game.convert_grid_index(invalid_row, invalid_cell)).to eql(nil)
      end
    end

    context 'when the input is valid' do
      let(:row) { 'top' }
      let(:cell) { 'left' }

      it 'returns the move(array of 2 elements)' do
        expect(game.convert_grid_index(row, cell)).to eql([0, 0])
      end
    end
  end
end
