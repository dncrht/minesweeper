require 'set'
@visited = Set.new

ROWS = 5
COLS = 10
NUM = 3

mines = Array.new(ROWS) { Array.new(COLS) }
@playfield = Array.new(ROWS) { Array.new(COLS) }

# no vale pq se repiten
#NUM.times do
#  mines[rand(ROWS)][rand(COLS)] = true
#end

c = NUM
begin
  x = rand(COLS)
  y = rand(ROWS)
  unless mines[y][x]
    mines[y][x] = true
    c -= 1
  end
end until c.zero?

def p_m(mines)
  mines.each do |row|
    puts row.map { |c| c ? 'X' : '.' }.join
  end
end

def p_p
  @playfield.each do |row|
    puts row.map { |c| c ? c.to_s : '.' }.join
  end
end

def minecounter(mines, y, x)
  count = 0
  (-1).upto(1).each do |dx|
    (-1).upto(1).each do |dy|
      next if dx.zero? && dy.zero?
      next if x + dx < 0
      next if y + dy < 0
      next if x + dx >= COLS
      next if y + dy >= ROWS

      if mines[y + dy][x + dx]
        count += 1
      end
    end
  end

  count
end

def tally(mines)
  mines.each_with_index do |row, y|
    x = -1
    puts row.map { |_| x += 1;
    minecounter(mines, y, x)}.join
  end
end

# game loop
def reveal_adjacent(mines, y, x)
  (-1).upto(1).each do |dx|
    (-1).upto(1).each do |dy|
      next if dx.zero? && dy.zero?
      next if x + dx < 0
      next if y + dy < 0
      next if x + dx >= COLS
      next if y + dy >= ROWS

      content = minecounter(mines, y + dy, x + dx)
      @playfield[y + dy][x + dx] = content
      #p_p
      #puts @visited.inspect
      #gets
      if @playfield[y + dy][x + dx].zero? && !@visited.include?([y + dy, x + dx])
        @visited << [y + dy, x + dx]
        reveal_adjacent(mines, y + dy, x + dx)
      end
    end
  end
end

def left
  @playfield.flatten.select(&:nil?).size
end

loop do
  p_p
  puts
  p_m mines
  puts
  tally mines
  puts
  input = gets.strip
  if input.include? ','
    x, y = input.split(',').map &:to_i

    if mines[y][x]
      puts 'lose!'
      exit 1
    end
    content = minecounter(mines, y, x)
    @playfield[y][x] = content
    @visited << [y, x]
    if content.zero? # reveal adjacent
      reveal_adjacent(mines, y, x)
    end

    if left == NUM
      puts 'the winner is you!'
      exit 0
    end
  end
end
