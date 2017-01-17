require 'set'

class Playfield
  def initialize(mine_number:, rows:, cols:)
    @mine_number = mine_number
    @rows = rows
    @cols = cols

    @revealed_squares = Set.new
    @mines = Set.new
    @playfield = Array.new(rows) { Array.new(cols) }

    until mine_number.zero?
      mine_position = [rand(rows), rand(cols)]
      unless @mines.include?(mine_position)
        @mines << mine_position
        mine_number -= 1
      end
    end
  end

  def display
    @playfield.each do |row|
      puts row.map { |cell| cell ? cell.to_s : '.' }.join
    end
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

  def squares_left?
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

class Game
  ROWS = 5
  COLS = 10
  NUM = 3

  def initialize
    @playfield = Playfield.new(mine_number: NUM, rows: ROWS, cols: COLS)
  end

  def play
    @playfield.display

    loop do
      puts "Enter position to reveal as: y, x"
      input = gets.strip

      if input.include? ','
        y, x = input.split(',').map &:to_i

        if @playfield.has_mine?(y, x)
          puts "\n\nLose!"
          exit 1
        end
        @playfield.reveal_square(y, x)
        puts
        @playfield.display

        if @playfield.squares_left?
          puts "\n\nThe winner is you!"
          exit 0
        end
      end
    end
  end
end

Game.new.play
