require 'set'

class Playfield
  def initialize(mine_number:, rows:, cols:)
    @mine_number = mine_number
    @rows = rows
    @cols = cols

    @revealed_squares = Set.new
    @mines = Array.new(rows) { Array.new(cols) }
    @playfield = Array.new(rows) { Array.new(cols) }

    c = mine_number
    until c.zero?
      x = rand(cols)
      y = rand(rows)
      unless @mines[y][x]
        @mines[y][x] = true
        c -= 1
      end
    end
  end

  def display
    @playfield.each do |row|
      puts row.map { |cell| cell ? cell.to_s : '.' }.join
    end
  end

  def has_mine?(y, x)
    @mines[y][x]
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

        if @mines[y + dy][x + dx]
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
    loop do
      @playfield.display
      puts
      input = gets.strip

      if input.include? ','
        x, y = input.split(',').map &:to_i

        if @playfield.has_mine?(y, x)
          puts 'lose!'
          exit 1
        end
        @playfield.reveal_square(y, x)

        if @playfield.squares_left?
          puts 'the winner is you!'
          exit 0
        end
      end
    end
  end
end

Game.new.play
