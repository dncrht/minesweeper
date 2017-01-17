require 'set'
visited = Set.new

ROWS = 5
COLS = 10
NUM = 3

mines = Array.new(ROWS) { Array.new(COLS) }
playfield = Array.new(ROWS) { Array.new(COLS) }

c = NUM
until c.zero?
  x = rand(COLS)
  y = rand(ROWS)
  unless mines[y][x]
    mines[y][x] = true
    c -= 1
  end
end

def p_p(playfield)
  playfield.each do |row|
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

# game loop
def reveal_adjacent(visited, playfield, mines, y, x)
  (-1).upto(1).each do |dx|
    (-1).upto(1).each do |dy|
      next if dx.zero? && dy.zero?
      next if x + dx < 0
      next if y + dy < 0
      next if x + dx >= COLS
      next if y + dy >= ROWS

      reveal_position(visited, playfield, mines, y + dy, x + dx)
    end
  end
end

def left(playfield)
  playfield.flatten.select(&:nil?).size
end

def reveal_position(visited, playfield, mines, y, x)
  content = minecounter(mines, y, x)
  playfield[y][x] = content
  if content.zero? && !visited.include?([y, x])
    visited << [y, x]
    reveal_adjacent(visited, playfield, mines, y, x)
  end
end

loop do
  p_p(playfield)
  puts
  input = gets.strip
  if input.include? ','
    x, y = input.split(',').map &:to_i

    if mines[y][x]
      puts 'lose!'
      exit 1
    end
    reveal_position(visited, playfield, mines, y, x)

    if left(playfield) == NUM
      puts 'the winner is you!'
      exit 0
    end
  end
end
