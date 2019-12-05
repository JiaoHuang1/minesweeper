class Board
    attr_reader :board, :play_board

    def initialize
        @board = Array.new(9) {Array.new(9, " ")}
        ### @play_board the board player can see, it updates player's move
        @play_board = Array.new(9) {Array.new(9, "*")}
        @size = @board.length * @board[0].length
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @board[row][col] = val
    end

    #-----------randomly set bombs in to a empty 9*9 board----------------------

    def set_mine
        ### set 10 bombs for a 8*8 board which is 1 : 6.4
        num_of_bomb = (@size / 6.4).floor
        until self.count_bomb(board) == num_of_bomb
            pos = [rand(0..8), rand(0..8)]
            self.add_bomb(pos)
        end
    end

    def count_bomb(grids)
        count = 0
        board.each do |rows|
            rows.each do |grid|
                if grid == :B
                    count += 1
                end
            end
        end
        count
    end

    def add_bomb(pos)
        self[pos] = :B
    end

    #-----------fill number of bombs for surrounding grid on the board----------

    def fill_number(grids)
        grids.each_with_index do |rows, r|
            rows.each_with_index do |grid, c|
                pos = [r, c]
                self[pos] = surrouding_bomb(pos) if grid == " " && surrouding_bomb(pos) != 0
            end
        end
    end

    def surrounding_grid(pos)
        surrouding = []
        row, col = pos
        (row - 1..row + 1).each do |r|
            (col - 1..col + 1).each do |c|
                if (0..8).include?(r) && (0..8).include?(c) && !(r == row && c == col)
                    surrouding << [r, c]
                end
            end
        end
        surrouding
    end

    def surrouding_bomb(pos)
        count = 0
        surrounding_grid(pos).each do |position|
            count += 1 if self[position] == :B
        end
        count
    end

    def print(grids)
        puts "  #{(0..8).to_a.join(" ")}"
        grids.each_with_index do |rows, i|
            puts "#{i} #{rows.join(" ")}"
        end
    end
end


