A minimalistic Ruby implementation for the classic minesweeper [game](https://en.wikipedia.org/wiki/Minesweeper_(video_game)).

In case you don't know, the objective is to reveal the content of all the squares without a mine.

# Installation

It comes conveniently packaged as a gem:

`gem install minesweeper-cli`


# How to launch the game

From the command line:

`minesweeper`

To get some help and options:

`minesweeper -h`

By default it's a 10x5 grid, with 3 hidden mines.

# How to play

Enter the position of the square you want to reveal, by typing the coordinates Y and X. Eg:

`2,3`

…and press enter.

The origin `0, 0` is at the leftmost top corner, marked in the diagram below as `O`.
And `2, 3` would be the square marked as `X`:

```
O....
.....
...X.
.....
```

The game ends either once you reveal all the squares, or hit a mine.
In any case, the program ends and you'll be notified in [Engrish](http://knowyourmeme.com/memes/a-winner-is-you).
