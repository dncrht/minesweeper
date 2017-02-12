require 'spec_helper'

module Minesweeper
  RSpec.describe Playfield do

    let(:options) { {mine_number: 0, display_set: :text, rows: 3, cols: 3} }
    subject { described_class.new(**options) }

    describe '#has_mine?' do
      it 'does not have a mine at position' do
        subject.instance_variable_set :@mines, [[0, 0]]

        expect(subject.has_mine?(0, 0)).to eq true
      end

      it 'has a mine at position' do
        subject.instance_variable_set :@mines, [[0, 1]]

        expect(subject.has_mine?(0, 0)).to eq false
      end
    end

    describe '#squares_left?' do
      it 'has squares to be revealed (9x9)' do
        expect(subject.all_squares_revealed?).to eq false
      end

      it 'has squares to be revealed (3x1, 1 mine)' do
        subject.instance_variable_set :@playfield, [[1, true, 1]]

        expect(subject.all_squares_revealed?).to eq true
      end
    end

    describe '#mines_around' do
      it 'has no mines around' do
        expect(subject.mines_around(1, 1)).to eq 0
      end

      it 'has 1 mine around' do
        subject.instance_variable_set :@mines, [[0, 0]]

        expect(subject.mines_around(1, 1)).to eq 1
      end

      it 'has 2 mines around' do
        subject.instance_variable_set :@mines, [[0, 0], [0, 1]]

        expect(subject.mines_around(1, 1)).to eq 2
      end

      it 'has 3 mines around' do
        subject.instance_variable_set :@mines, [[0, 0], [0, 1], [0, 2]]

        expect(subject.mines_around(1, 1)).to eq 3
      end

      it 'has 4 mines around' do
        subject.instance_variable_set :@mines, [[0, 0], [0, 1], [0, 2], [1, 0]]

        expect(subject.mines_around(1, 1)).to eq 4
      end

      it 'has 5 mines around' do
        subject.instance_variable_set :@mines, [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2]]

        expect(subject.mines_around(1, 1)).to eq 5
      end

      it 'has 6 mines around' do
        subject.instance_variable_set :@mines, [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0]]

        expect(subject.mines_around(1, 1)).to eq 6
      end

      it 'has 7 mines around' do
        subject.instance_variable_set :@mines, [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1]]

        expect(subject.mines_around(1, 1)).to eq 7
      end

      it 'has 8 mines around' do
        subject.instance_variable_set :@mines, [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]]

        expect(subject.mines_around(1, 1)).to eq 8
      end

      it 'still has 8 mines around because it says _around_' do
        subject.instance_variable_set :@mines, [[0, 0], [0, 1], [0, 2], [1, 0], [1, 1], [1, 2], [2, 0], [2, 1], [2, 2]]

        expect(subject.mines_around(1, 1)).to eq 8
      end
    end
  end
end
