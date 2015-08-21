class Board
  WINNING_LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  def initialize
    @board = {}
    (1..9).each {|position| @board[position] = ' ' }
  end

  def draw
    system 'clear'
    puts
    puts "     |     |"
    puts "  #{@board[1]}  |  #{@board[2]}  |  #{@board[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@board[4]}  |  #{@board[5]}  |  #{@board[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@board[7]}  |  #{@board[8]}  |  #{@board[9]}"
    puts "     |     |"
    puts
  end

  def nine_positions_are_filled?
    empty_positions == []
  end

  def empty_positions
    @board.keys.select {|position| @board[position] == ' '}
  end

  def move(position, move)
    @board[position] = move 
  end

  def check_for_winner
    WINNING_LINES.each do |line|
      return "Player" if @board.values_at(*line).count('X') == 3
      return "Computer" if @board.values_at(*line).count('O') == 3
    end
    nil
  end

end

class Game
  attr_accessor :board

  def initialize
    @board = Board.new
  end

  def players_turn
    begin
      puts "Choose a position (from 1 to 9) to place a piece:"
      position = gets.chomp.to_i
    end until @board.empty_positions.include?(position)
    @board.move(position, 'X')
  end

  def computers_turn
    position = @board.empty_positions.sample
    @board.move(position, 'O')
  end

  def play
    @board.draw
    begin
      players_turn
      @board.draw
      computers_turn
      @board.draw
      winner = @board.check_for_winner
    end until winner || @board.nine_positions_are_filled?
    if winner
      puts winner + " won!"
    else 
      puts "It's a tie."
    end
  end
end

Game.new.play