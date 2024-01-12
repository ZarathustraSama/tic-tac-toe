# frozen_string_literal: true

require_relative '../lib/play'
require_relative '../lib/grid'
require_relative '../lib/game'

describe Play do
  describe '#play_game' do
    let(:grid) { instance_double(Grid) }
    let(:game) { instance_double(Game) }
    subject(:play) { described_class.new(grid, game) }

    context 'if the game is over, but none won' do
      before do
        allow(grid).to receive(:draw_grid)
        allow(grid).to receive(:get_current_player)
        allow(grid).to receive(:game_over?).and_return(true)
        allow(grid).to receive(:get_winner).and_return(nil)
      end

      it 'puts the "tie" message' do
        tie_message = 'Game Over: It\'s a tie!'
        expect(play).to receive(:puts).with(tie_message).once
        play.play_game
      end
    end

    context 'if the game is over, and X won' do
      before do
        allow(grid).to receive(:draw_grid)
        allow(grid).to receive(:get_current_player)
        allow(grid).to receive(:game_over?).and_return(true)
        allow(grid).to receive(:get_winner).and_return('X')
      end

      it 'puts the "winner" message' do
        player = grid.get_winner
        winner_message = "Game Over: #{player} wins!"
        expect(play).to receive(:puts).with(winner_message).once
        play.play_game
      end
    end

    context 'if the game is not over until the next turn' do
      before do
        allow(grid).to receive(:draw_grid)
        allow(grid).to receive(:get_current_player)
        allow(grid).to receive(:game_over?).and_return(false, true)
        allow(grid).to receive(:grid)
        allow(game).to receive(:ask_user_move).and_return([0, 0])
        allow(grid).to receive(:make_move).and_return(grid)
        allow(grid).to receive(:get_winner).and_return('X')
      end

      it 'puts the "next player" message once' do
        player = grid.get_current_player
        winner = grid.get_winner
        winner_message = "Game Over: #{winner} wins!"
        next_player_message = "Player #{player}'s turn"
        expect(play).to receive(:puts).with(next_player_message).once
        expect(play).to receive(:puts).with(winner_message).once
        play.play_game
      end
    end
  end
end
