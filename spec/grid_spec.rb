require 'spec_helper'
require_relative '../app/grid'

describe Grid do
  let(:grid) { described_class.new }

  describe '[][]' do
    it { expect(grid[0][0]).to eq(:empty) }
    it 'display cell' do
      for i in 0..6 do
        for j in 0..5 do
          expect(grid[i][j]).to eq(:empty)
        end
      end
    end
  end

  describe '#add_token' do
    context 'when adding token in first column' do
      before do
        grid.add_token(0, :red)
      end
      it { expect(grid[0][0]).to eq(:red) }
    end
    context 'when adding tow token' do
      before do
        grid.add_token(1, :red)
        grid.add_token(2, :yellow)
      end
      it { expect(grid[1][0]).to eq(:red) }
      it { expect(grid[2][0]).to eq(:yellow) }
    end
    context 'when adding two token in the same column' do
      before do
        grid.add_token(1, :red)
        grid.add_token(1, :yellow)
      end
      it 'stacks the tokens' do
        expect(grid[1][0]).to eq(:red)
        expect(grid[1][1]).to eq(:yellow)
      end
    end
    context 'when adding more than 6 tokens' do
      before do
        6.times do
          grid.add_token(1, :red)
        end
      end

      it { expect{ grid.add_token(1, :red)}.to raise_error(IndexError) }
    end
  end

  describe '#empty' do
    before do
      for i in 0..6 do
        for j in 0..5 do
          grid.add_token(i,:red)
        end
      end
    end
    it 'empties the grid' do
      grid.empty
      for i in 0..6 do
        for j in 0..5 do
          expect(grid[i][j]).to eq(:empty)
        end
      end
    end
  end

  describe '#to_s' do
    before do
      grid.add_token(1,:red)
      grid.add_token(2,:yellow)
    end
    it 'displays grid' do
      pretty_grid = ".......\n" +
                    ".......\n" +
                    ".......\n" +
                    ".......\n" +
                    ".......\n" +
                    ".0*....\n"
      expect(grid.to_s).to eq pretty_grid
    end
  end

  describe '#ascending_diagonals' do
    subject { grid.ascending_diagonals }

    describe 'when grid is empty' do
      let(:result) {
        [
          [:empty],
          [:empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty],
          [:empty]
        ]

      }
      it { is_expected.to eq(result) }
    end
    describe 'when grid is filled' do
      let(:result) {
        [
          [:empty],
          [:empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty],
          [:yellow, :red],
          [:red]
        ]

      }
      before do
        grid.add_token(5, :yellow)
        grid.add_token(6, :red)
        grid.add_token(6, :red)
      end
      it { is_expected.to eq(result) }
    end

    describe 'when grid is filled' do
      let(:result) {
        [
          [:empty],
          [:empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:red, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty],
          [:empty]
        ]

      }
      before do
        grid.add_token(0, :red)
      end

      it { is_expected.to eq(result) }
    end

    describe 'when grid is filled' do
      let(:result) {
        [
          [:empty],
          [:empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:yellow, :empty, :empty, :empty, :empty],
          [:red, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty],
          [:yellow, :red],
          [:red]
        ]

      }
      before do
        grid.add_token(0, :red)
        grid.add_token(0, :yellow)
        grid.add_token(5, :yellow)
        grid.add_token(6, :red)
        grid.add_token(6, :red)

      end

      it { is_expected.to eq(result) }
    end
  end

  describe '#descending_diagonals' do
    subject { grid.descending_diagonals }
     describe 'when grid is empty' do
      let(:result) {
        [
          [:empty],
          [:empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty],
          [:empty]
        ]

      }
      it { is_expected.to eq(result) }
    end

    describe 'when grid is filled' do
      let(:result) {
        [
          [:red],
          [:empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
          [:empty, :empty, :empty],
          [:empty, :empty],
          [:empty]
        ]

      }

      before do
        grid.add_token(0, :red)
      end

      it { is_expected.to eq(result) }
    end

    describe 'when grid is filled multiple times' do
      let(:result) {
        [
                    [:red],
                [:yellow, :red],
            [:empty, :empty, :empty],
          [:empty, :empty, :empty, :empty],
      [:empty, :empty, :empty, :empty, :empty],
  [:empty, :empty, :empty, :empty, :empty, :empty],
  [:empty, :empty, :empty, :empty, :empty, :empty],
    [:empty, :empty, :empty, :empty, :empty],
        [:empty, :empty, :empty, :empty],
            [:empty, :empty, :empty],
                [:empty, :empty],
                      [:empty]
        ]

      }

      before do
        grid.add_token(0, :red)
        grid.add_token(0, :yellow)
        grid.add_token(1, :red)
      end

      it { is_expected.to eq(result) }

    end
  end
end