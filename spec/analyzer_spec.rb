require 'spec_helper'
require_relative '../app/grid'
require_relative '../app/analyzer'

describe Analyzer do
  describe '#state' do
    let(:grid) { Grid.new }
    let(:analyzer) { described_class.new(grid) }
    subject { analyzer.state }
    context 'when game is still running' do
      it { is_expected.to eq(:running) }
    end

    context 'when game is won' do
      context 'on a line' do
        context 'starting in the first column' do
          before do
            grid.add_token 0, :red
            grid.add_token 1, :red
            grid.add_token 2, :red
            grid.add_token 3, :red
          end

          it { is_expected.to eq(:won) }
        end
        context 'starting in the second column' do
          before do
            grid.add_token 1, :red
            grid.add_token 2, :red
            grid.add_token 3, :red
            grid.add_token 4, :red
          end

          it { is_expected.to eq(:won) }
        end

        context 'starting in the second column and second row' do
          before do
            grid.add_token 1, :red
            grid.add_token 2, :yellow
            grid.add_token 3, :red
            grid.add_token 4, :red

            grid.add_token 1, :yellow
            grid.add_token 2, :yellow
            grid.add_token 3, :yellow
            grid.add_token 4, :yellow
          end

          it { is_expected.to eq(:won) }
        end
      end
      context 'on a column' do
        context 'in the first column' do
          before do
            4.times do
              grid.add_token 0, :yellow
            end
          end

          it { is_expected.to eq(:won) }
        end
      end
      context 'in an ascending diagonal' do
        before do
          grid.add_token 1, :red
          grid.add_token 2, :yellow
          grid.add_token 3, :red
          grid.add_token 4, :red
          grid.add_token 2, :red
          grid.add_token 3, :yellow
          grid.add_token 4, :yellow
          grid.add_token 3, :red
          grid.add_token 4, :red
          grid.add_token 4, :red
        end
        it { is_expected.to eq(:won) }
      end

      context 'in an ascending diagonal' do
        before do
          grid.add_token 6, :red
        end
        it { is_expected.to eq(:running) }
      end

      context 'in an descending diagonal' do
        before do
          grid.add_token 1, :yellow
          grid.add_token 1, :yellow
          grid.add_token 1, :yellow
          grid.add_token 1, :red
          grid.add_token 2, :red
          grid.add_token 2, :red
          grid.add_token 2, :red
          grid.add_token 3, :yellow
          grid.add_token 3, :red
          grid.add_token 4, :red
        end
        it { is_expected.to eq(:won) }
      end
    end
    context 'when game is null' do
      before do
        grid.add_token(0,:red)
        grid.add_token(0,:red)
        grid.add_token(0,:yellow)
        grid.add_token(0,:red)
        grid.add_token(0,:yellow)
        grid.add_token(0,:red)

        grid.add_token(1,:yellow)
        grid.add_token(1,:yellow)
        grid.add_token(1,:red)
        grid.add_token(1,:yellow)
        grid.add_token(1,:red)
        grid.add_token(1,:yellow)

        grid.add_token(2,:red)
        grid.add_token(2,:yellow)
        grid.add_token(2,:red)
        grid.add_token(2,:yellow)
        grid.add_token(2,:red)
        grid.add_token(2,:yellow)

        grid.add_token(3,:yellow)
        grid.add_token(3,:red)
        grid.add_token(3,:yellow)
        grid.add_token(3,:red)
        grid.add_token(3,:yellow)
        grid.add_token(3,:red)

        grid.add_token(4,:yellow)
        grid.add_token(4,:red)
        grid.add_token(4,:yellow)
        grid.add_token(4,:red)
        grid.add_token(4,:red)
        grid.add_token(4,:yellow)

        grid.add_token(5,:red)
        grid.add_token(5,:yellow)
        grid.add_token(5,:red)
        grid.add_token(5,:yellow)
        grid.add_token(5,:red)
        grid.add_token(5,:yellow)

        grid.add_token(6,:yellow)
        grid.add_token(6,:red)
        grid.add_token(6,:yellow)
        grid.add_token(6,:red)
        grid.add_token(6,:yellow)
        grid.add_token(6,:red)

     end
     it { is_expected.to eq(:draw) }
    end
  end
end
