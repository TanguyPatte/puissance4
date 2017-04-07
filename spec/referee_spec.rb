require 'spec_helper'
require_relative '../app/grid'
require_relative '../app/referee'

describe Referee do
  let(:referee) { described_class.new }
  describe '#current_player' do
    subject { referee.current_player }
    context 'when no player has played yet' do
      it { is_expected.to eq(:yellow) }
    end
  end

  describe '#render' do
    it 'calls to_s on grid' do
      allow_any_instance_of(Grid).to receive(:to_s).and_return("toto")
      expect(referee.render).to eq("toto")
    end
  end

  describe '#add_token' do
    context 'when the first player plays' do
      before do
        referee.add_token 3
      end
      it 'toggle current player' do
        expect(referee.current_player).to eq(:red)
      end
      context 'then second player plays' do
        it 'calls add_token on a grid' do
          expect_any_instance_of(Grid).to receive(:add_token).with(3,:red)
          referee.add_token 3
        end
      end
    end
    context 'switch to yellow when red plays' do
      before do
        referee.add_token 3
        referee.add_token 3
      end
      it { expect(referee.current_player).to eq(:yellow) }
    end

    context "raise an error when the column doesn't exist" do
      context 'with column number = 8' do
        it { expect{ referee.add_token 8 }.to raise_error(InvalidMoveError) }
      end
      context 'with column number = -1' do
        it { expect{ referee.add_token -1 }.to raise_error(InvalidMoveError) }
      end
    end

    context "raise an InvalidMoveError when the column is full" do
      before do
        6.times do
          referee.add_token 3
        end
      end

      it { expect{ referee.add_token 3}.to raise_error(InvalidMoveError) }
    end

    context "when the game is ended" do
      before do
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
      end

      it 'raise an EndedGameError' do
        expect{ referee.add_token 4}.to raise_error(EndedGameError)
      end
    end
  end

  describe '#game_status' do
    subject { referee.game_status }
    it 'calls Analyzer state function' do
      expect_any_instance_of(Analyzer).to receive(:state)
      referee.game_status
    end
    context 'when game is running' do
      it { is_expected.to eq(:running) }
    end

    context 'when the game is won' do
      before do
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
      end

      it { is_expected.to eq(:won) }
    end
  end

  describe '#winner' do
    subject { referee.winner }
    context 'when yellow wins' do
      before do
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
        referee.add_token 1
        referee.add_token 0
      end
      it { is_expected.to eq(:yellow) }
    end
  end
end