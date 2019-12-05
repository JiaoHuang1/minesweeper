class Player
    #----------------get position from player-----------------------------------
    def get_pos
        pos = nil
        until pos && valid_pos?(pos)
            puts "Please enter a position, such as '4 7'"
            pos = gets.chomp
        end
        [pos[0].to_i, pos[2].to_i]
    end

    def valid_pos?(pos)
        if pos.length == 3 && (0..8).include?(pos[0].to_i) && (0..8).include?(pos[2].to_i) && pos[1] == " "
            return true
        else
            puts "Invalid entry! Please enter a position like '4 7'"
            return false
        end
    end

    #-------------------get value from player-----------------------------------

    def get_val
        val = nil
        until val && valid_val?(val)
            puts "Please enter 'f' for flag, 'r' for reveal"
            val = gets.chomp
        end
        val
    end

    def valid_val?(val)
        if val == "f" || val == "r"
            return true
        else  
            puts "Invalid entry! You can only enter lower case 'f' or 'r'."
            return false
        end
    end
end