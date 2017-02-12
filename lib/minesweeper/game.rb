require_relative 'playfield'

module Minesweeper
  class Game
    def initialize(options)
      @playfield = Playfield.new(**options)
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

          if @playfield.all_squares_revealed?
            @playfield.display_with_mines
            puts "\n\nThe winner is you!"
            exit
          end
          @playfield.display
        end
      end
    end
  end
end
