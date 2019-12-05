require_relative "board"
require_relative "player"

class Game
    attr_reader :lose

    def initialize
        @board = Board.new
        @board.set_mine
        @board.fill_number(@board.board)
        @player = Player.new
        @lose = false
    end

    def reveal_surrounding(pos)
        row, col = pos
        @board.play_board[row][col] = @board[pos]

        if @board[pos] != " "
            return
        end

        @board.surrounding_grid(pos).each do |surrounding_coordinate|
            r, c = surrounding_coordinate
            if @board.play_board[r][c] == "*"  ### this is to make sure the revealed grid is not visited again! other wise the loop is too deep.
                self.reveal_surrounding(surrounding_coordinate)
            end 
        end
    end

    def revealed?(pos)
        row, col = pos
        if @board.play_board[row][col] == "*" || @board.play_board[row][col] == "f"
            return false
        end
        true
    end


    def play_turn
        pos = @player.get_pos
        while revealed?(pos)
            puts "You can modify a revealed position."
            pos = @player.get_pos
        end
        val = @player.get_val
        row, col = pos

        if val == "r" && @board[pos] == :B
            @board.play_board[row][col] = :B
            puts "You lose!"
            @lose = true
            return
        end

        if val == "r"
            self.reveal_surrounding(pos)
        else  
            @board.play_board[row][col] = "f"
        end
    end

    def win?
        @board.play_board.each_with_index do |rows, r|
            rows.each_with_index do |grid, c|
                if @board.play_board[r][c] == "*" || (@board.play_board[r][c] == "f" && @board.board[r][c] != :B)
                    return false
                end
            end
        end
        puts "You win!"
        true
    end

    def game_over?
        return true if win? || self.lose
        false
    end

    def run 
        until game_over? do
            self.print(@board.play_board)
            self.play_turn   
        end
        self.print(@board.play_board)
        self.print(@board.board)
    end

    def print(board)
        @board.print(board)
    end

end

game = Game.new
game.run