ROWS = 5
COLS = 10
NUM = 5

mines = Array.new(ROWS) { Array.new(COLS) }
playfield = Array.new(ROWS) { Array.new(COLS) }

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

def p_p(mines)
  mines.each do |row|
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
def reveal_adjacent(mines, playfield, y, x)
  (-1).upto(1).each do |dx|
    (-1).upto(1).each do |dy|
      next if dx.zero? && dy.zero?
      next if x + dx < 0
      next if y + dy < 0
      next if x + dx >= COLS
      next if y + dy >= ROWS

      content = minecounter(mines, y + dy, x + dx)
      if content.zero? # reveal adjacent
        reveal_adjacent(mines, playfield, y + dy, x + dx) if playfield[y + dy][x + dx].nil?
      end

      playfield[y + dy][x + dx] = content
    end
  end
end

loop do
  p_p playfield
  puts
  p_m mines
  puts
  tally mines
  puts
  input = gets.strip
  if input.include? ','
    x, y = input.split(',').map &:to_i

    if mines[y][x]
      exit 1
    end
    content = minecounter(mines, y, x)
    if content.zero? # reveal adjacent
      reveal_adjacent(mines, playfield, y, x)
    end
    playfield[y][x] = content
  end
end
