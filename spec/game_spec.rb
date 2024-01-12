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

  describe '#ask_user_move' do
    subject(:game_input) { described_class.new }
    let(:grid) { [['X', nil, nil], [nil, nil, nil], [nil, nil, nil]] }

    context 'when the input is valid' do
      before do
        valid_input = 'top right'
        allow(game_input).to receive(:gets).and_return(valid_input)
      end

      it 'stops the loop and returns the move' do
        error_message = 'You can\'t do that!'
        expect(game_input).not_to receive(:puts).with(error_message)
        game_input.ask_user_move(grid)
      end
    end

    context 'when the input is invalid two times, then valid' do
      before do
        invalid_input1 = 'top left'
        invalid_input2 = 'sfseaf'
        valid_input = 'bottom left'
        allow(game_input).to receive(:gets).and_return(invalid_input1, invalid_input2, valid_input)
      end

      it 'sends two times the error message before stopping' do
        default_message = 'Choose which row (top, middle, bottom) and which cell (left, center, right)'
        error_message = 'You can\'t do that!'
        expect(game_input).to receive(:puts).with(default_message).exactly(3).times
        expect(game_input).to receive(:puts).with(error_message).twice
        game_input.ask_user_move(grid)
      end
    end
  end
end
