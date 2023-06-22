class ConnectFour
  def initialize
    @board = Array.new(6) { Array.new(7, "-") }
    @current_player = "X"
    @game_over = false
  end

  def play
    while !@game_over
      display_board
      column = prompt_column
      place_piece(column)
      check_winner
      switch_player
    end
  end

  def display_board
    @board.each { |row| puts row.join(" ") }
    puts "1 2 3 4 5 6 7"
    puts
  end

  def prompt_column
    loop do
      puts "Player #{@current_player}, choose a column (1-7):"
      column = gets.chomp.to_i - 1
      return column if valid_column?(column)

      puts "Invalid column. Please choose a valid column."
    end
  end

  def valid_column?(column)
    column >= 0 && column <= 6 && @board[0][column] == "-"
  end

  def place_piece(column)
    row = 5
    while row >= 0
      if @board[row][column] == "-"
        @board[row][column] = @current_player
        break
      end
      row -= 1
    end
  end

  def check_winner
    if vertical_winner? || horizontal_winner? || diagonal_winner?
      display_board
      puts "Player #{@current_player} wins!"
      @game_over = true
    elsif board_full?
      display_board
      puts "It's a tie!"
      @game_over = true
    end
  end

  def vertical_winner?
    (0..5).each do |row|
      (0..3).each do |col|
        return true if @board[row][col] == @current_player &&
                        @board[row][col + 1] == @current_player &&
                        @board[row][col + 2] == @current_player &&
                        @board[row][col + 3] == @current_player
      end
    end
    false
  end

  def horizontal_winner?
    (0..2).each do |row|
      (0..6).each do |col|
        return true if @board[row][col] == @current_player &&
                        @board[row + 1][col] == @current_player &&
                        @board[row + 2][col] == @current_player &&
                        @board[row + 3][col] == @current_player
      end
    end
    false
  end

  def diagonal_winner?
    (0..2).each do |row|
      (0..3).each do |col|
        return true if @board[row][col] == @current_player &&
                        @board[row + 1][col + 1] == @current_player &&
                        @board[row + 2][col + 2] == @current_player &&
                        @board[row + 3][col + 3] == @current_player
      end
    end

    (0..2).each do |row|
      (3..6).each do |col|
        return true if @board[row][col] == @current_player &&
                        @board[row + 1][col - 1] == @current_player &&
                        @board[row + 2][col - 2] == @current_player &&
                        @board[row + 3][col - 3] == @current_player
      end
    end

    false
  end

  def board_full?
    @board.all? { |row| !row.include?("-") }
  end

  def switch_player
    @current_player = @current_player == "X" ? "O" : "X"
  end
end

game = ConnectFour.new
game.play
