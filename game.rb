#!/usr/bin/env ruby

require_relative 'playfield'

class Game
  ROWS = 5
  COLS = 10
  NUM = 3

  def initialize(argv)
    @playfield = Playfield.new(
      mine_number: argv[0] || NUM,
      rows:        argv[1] || ROWS,
      cols:        argv[2] || COLS,
    )
  end

  def play
    @playfield.display

    loop do
      puts "Enter position to reveal as: y, x"
      input = STDIN.gets.strip

      if input.include? ','
        y, x = input.split(',').map &:to_i

        puts
        if @playfield.has_mine?(y, x)
          @playfield.display_with_mines
          puts "\n\nLose!"
          exit 1
        end
        @playfield.reveal_square(y, x)

        if @playfield.squares_left?
          @playfield.display_with_mines
          puts "\n\nThe winner is you!"
          exit 0
        end
        @playfield.display
      end
    end
  end
end

if $0.include? 'game.rb'
  Game.new(ARGV.map &:to_i).play
end
