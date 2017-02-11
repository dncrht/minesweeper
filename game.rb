#!/usr/bin/env ruby

require 'optparse'
require_relative 'playfield'

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

if $0.include? 'game.rb'
  options = {
    display_set: :emoji,
    mine_number: 3,
    rows:        5,
    cols:        10,
  }

  opt_parser = OptionParser.new do |opt|
    opt.banner = 'Usage: game [OPTIONS]'
    opt.separator ''
    opt.separator 'Options'

    opt.on('-d', '--display_set SET', 'display the playfield using text or emoji (default)') do |display_set|
      options[:display_set] = display_set.to_sym
    end

    opt.on('-m', '--mine_number NUMBER', 'number of mines') do |mine_number|
      options[:mine_number] = mine_number.to_i
    end

    opt.on('-r', '--rows NUMBER', 'number of rows') do |rows|
      options[:rows] = rows.to_i
    end

    opt.on('-c', '--cols NUMBER', 'number of columns') do |cols|
      options[:cols] = cols.to_i
    end

    opt.on('-h', '--help', 'this message') do |environment|
      puts opt_parser
      exit
    end
  end
  opt_parser.parse!

  Game.new(options).play
end
