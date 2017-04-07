require 'spec_helper'
require_relative '../app/application'

describe Application do
  let(:application) { Application.new }

  describe '#display_grid' do
    let(:empty_grid) {
        ".......\n" +
        ".......\n" +
        ".......\n" +
        ".......\n" +
        ".......\n" +
        ".......\n"
      }
    it 'displays given grid' do
      expect(application).to receive(:puts).with(empty_grid)
      application.display_grid
    end
    context 'when first player plays in column 0' do
      before do
        allow(application).to receive(:gets).and_return('0')
        application.ask_and_play_move
      end
      let(:new_grid) {
        ".......\n" +
        ".......\n" +
        ".......\n" +
        ".......\n" +
        ".......\n" +
        "*......\n"
      }
      it 'displays the new grid' do
        expect(application).to receive(:puts).with(new_grid)
        application.display_grid
      end
    end
  end

  describe '#display_player' do
    it 'displays the name of the next player' do
      expect(application).to receive(:puts).with("Un nouveau joueur approche: JAUNE")
      application.display_player
    end
    context 'when first player has played' do
      before do
        allow(application).to receive(:gets).and_return('0')
        application.ask_and_play_move
      end
      it 'displays the color of the second player' do
        expect(application).to receive(:puts).with("Un nouveau joueur approche: ROUGE")
        application.display_player
      end
    end
  end

  describe '#display_winner' do
    context 'when the winner is YELLOW player' do
      it 'displays a message' do
        allow_any_instance_of(Referee).to receive(:game_status).and_return(:won)
        expect(application).to receive(:puts).with('And the winner is: JAUNE')
        application.display_winner
      end
    end

    context 'when the winner is RED player' do
      before do
        allow_any_instance_of(Referee).to receive(:game_status).and_return(:won)
        allow_any_instance_of(Referee).to receive(:current_player).and_return(:red)
      end
      it 'displays a message' do
        expect(application).to receive(:puts).with('And the winner is: ROUGE')
        application.display_winner
      end
    end

    context 'when the game is a draw' do
      before do
        allow_any_instance_of(Referee).to receive(:game_status).and_return(:draw)
      end
      it 'displays a message' do
        expect(application).to receive(:puts).with('All loosers')
        application.display_winner
      end
    end
  end

  describe '#ask_and_play_move' do
    it 'waits for a user input' do
      expect(application).to receive(:gets)
      application.ask_and_play_move
    end
  end

  describe '#ask_input' do
    context 'when input is a single digit number' do
      before do
        allow(application).to receive(:gets).and_return('1')
      end
      it 'returns this numer' do
        expect(application.ask_input).to eq(1)
      end
    end

    context 'when input is a single letter' do
      before do
        allow(application).to receive(:gets).and_return('a')
      end
      it 'returns this numer' do
        expect(application.ask_input).to eq(-1)
      end
    end
  end

  describe '#game_ended?' do
    before do
      allow_any_instance_of(Referee).to receive(:game_status).and_return(status)
    end
    subject { application.game_ended? }
    context 'when game is running' do
      let(:status) { :running }
      it { is_expected.to be_falsy }
    end
    context 'when game is won' do
      let(:status) { :won }
      it { is_expected.to be_truthy }
    end
    context 'when game is draw' do
      let(:status) { :draw }
      it { is_expected.to be_truthy }
    end
  end

  describe '#run' do
    before do
      allow_any_instance_of(described_class).to receive(:puts)
      allow_any_instance_of(described_class).to receive(:gets)
    end
    context 'when application just start' do
      it 'displays the grid' do
        allow(application).to receive(:game_ended?).and_return(false, true)
        expect(application).to receive(:display_grid)
        application.run
      end

      it 'displays the next play to play' do
        allow(application).to receive(:game_ended?).and_return(false, true)
        expect(application).to receive(:display_player)
        application.run
      end

      it 'wait for a user input' do
        allow(application).to receive(:game_ended?).and_return(false, true)
        expect(application).to receive(:ask_and_play_move)
        application.run
      end
    end
    context 'when user input is not correct' do
      it 'ask player input again' do
        allow(application).to receive(:game_ended?).and_return(false, true)
        allow(application).to receive(:gets).and_return('8','1')
        expect(application).to receive(:ask_and_play_move).exactly(2).times.and_call_original
        application.run
      end
    end

    context 'when the game is won' do
      before do
        allow(application).to receive(:gets).and_return('0','1', '0','1', '0','1', '0')
      end
      it 'displays the winner\'s name' do
        expect(application).to receive(:display_winner)
        application.run
      end
      it 'displays the winning grid' do

      end
    end
  end
end