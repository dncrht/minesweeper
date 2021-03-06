require 'set'
require_relative 'square'

module Minesweeper
  class Playfield

    def initialize(options = {})
      @display_set = options[:display_set]
      @mine_number = options[:mine_number]
      @rows = options[:rows]
      @cols = options[:cols]

      @revealed_squares = Set.new
      @mines = Set.new
      @playfield = Array.new(@rows) { Array.new(@cols) }

      until options[:mine_number].zero?
        mine_position = [rand(@rows), rand(@cols)]
        unless @mines.include?(mine_position)
          @mines << mine_position
          options[:mine_number] -= 1
        end
      end
    end

    def display
      @playfield.each do |row|
        puts row.map { |content| Square.new(@display_set).display(content) }.join
      end
    end

    def display_with_mines
      @mines.each do |mine|
        y, x = mine
        @playfield[y][x] = true
      end
      display
    end

    def within_boundaries?(y, x)
      y >= 0 && y < @rows && x >= 0 && x < @cols
    end

    def has_mine?(y, x)
      @mines.include?([y, x])
    end

    def mines_around(y, x)
      count = 0
      (-1).upto(1).each do |dx|
        (-1).upto(1).each do |dy|
          next if dx.zero? && dy.zero?
          next if x + dx < 0
          next if y + dy < 0
          next if x + dx >= @cols
          next if y + dy >= @rows

          if has_mine?(y + dy, x + dx)
            count += 1
          end
        end
      end

      count
    end

    def all_squares_revealed?
      @playfield.flatten.select(&:nil?).size == @mine_number
    end

    def reveal_adjacent(y, x)
      (-1).upto(1).each do |dx|
        (-1).upto(1).each do |dy|
          next if dx.zero? && dy.zero?
          next if x + dx < 0
          next if y + dy < 0
          next if x + dx >= @cols
          next if y + dy >= @rows

          reveal_square(y + dy, x + dx)
        end
      end
    end

    def reveal_square(y, x)
      number_mines_around = mines_around(y, x)
      @playfield[y][x] = number_mines_around
      if number_mines_around.zero? && !@revealed_squares.include?([y, x])
        @revealed_squares << [y, x]
        reveal_adjacent(y, x)
      end
    end
  end
end
