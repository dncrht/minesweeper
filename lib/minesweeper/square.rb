module Minesweeper
  class Square
    TEXT_SET = {
      nil => '.',
      0   => '0',
      1   => '1',
      2   => '2',
      3   => '3',
      4   => '4',
      5   => '5',
      6   => '6',
      7   => '7',
      8   => '8',
      true => 'X',
    }

    EMOJI_SET = {
      nil => ' ✴️',
      0   => ' ✅',
      1   => ' 1️⃣',
      2   => ' 2️⃣',
      3   => ' 3️⃣',
      4   => ' 4️⃣',
      5   => ' 5️⃣',
      6   => ' 6️⃣',
      7   => ' 7️⃣',
      8   => ' 8️⃣',
      true => ' 💣',
    }

    CHARACTER_SETS = {
      emoji: EMOJI_SET,
      text:  TEXT_SET,
    }

    def initialize(set = :emoji)
      @character_set = CHARACTER_SETS[set]
    end

    def display(content)
      @character_set[content]
    end
  end
end
