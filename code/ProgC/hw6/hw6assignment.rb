# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece

  # The constant All_My_Pieces should be declared here
  All_My_Pieces = All_Pieces + 
               [rotations([[0, 0], [1, 0], [0, 1], [1, 1], [0, 2]]), # Square with one extra 
               [[[0, 0], [-1, 0], [1, 0], [2, 0], [3, 0]], # Long Long 
               [[0, 0], [0, -1], [0, 1], [0, 2], [0, 3]]],
               rotations([[0, 0], [1, 0], [0, 1]])] # Short L 

  # class method to choose the next piece
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
  
  # class method to choose the next piece as cheat piece
  def self.cheat_piece (board)
    MyPiece.new([[[[0, 0]]]].sample, board)
  end

end

class MyBoard < Board
  
  def initialize(game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @cheat_enabled = false
  end
  
  # rotate two times clockwise (180 degrees)
  def rotate_180_degrees
    rotate_clockwise; rotate_clockwise
  end
  
  # override for work with MyPiece and allow cheat piece
  def next_piece
    if @cheat_enabled
      @current_block = MyPiece.cheat_piece(self)
      toggle_cheat
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  # override for pieces of variable length
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(locations.size-1)).each{|index|  # locations.size for pieces of different size
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
  
  def toggle_cheat
    @cheat_enabled = !@cheat_enabled
  end
  
  attr_reader :cheat_enabled
  attr_accessor :score

end

class MyTetris < Tetris

  # override for compability with MyBoard
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  # add rotate_180_degrees and cheat piece functionalit
  def key_bindings
    super()
    @root.bind('u', proc {@board.rotate_180_degrees})
    @root.bind('c', proc {cheat})
  end
 
  # only if the score is enough to cheat and board it hasn't already had cheat enabled
  def cheat
    if (@board.score >= 100 and !@board.cheat_enabled)
      @board.score -= 100
      @board.toggle_cheat
    end
  end

end