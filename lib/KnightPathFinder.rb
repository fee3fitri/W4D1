require_relative "00_tree_node.rb"
require "byebug"

class KnightPathFinder 
    attr_reader :start, :tree, :considered_positions
    @@arr = []

    def initialize(start)
        @start = PolyTreeNode.new(start)
        @considered_positions = []
        @tree = build_move_tree
        @@arr = KnightPathFinder.valid_moves
    end 

    def inspect
        return "<#{@considered_positions.length}, #{@start.value}>"
    end 
 
    def build_move_tree
        queue = []
        queue << @start
        until queue.empty?
            # debugger 
            ele = queue.shift
            new_move_positions(ele).each do |node|
                queue << node
            end
        end        
        @tree
    end 
    
    def self.valid_moves
       @@arr = Array.new(8) { Array.new(8) }
        @@arr.each_with_index do |row, i|
            row.each_with_index do |el, j|
                @@arr[i][j] = i + 1, j + 1
            end
        end
    end 

    def new_move_positions(pos)
        # debugger
        moves = []
        if !@considered_positions.include?(pos.value) 
            @considered_positions << pos.value 
        end
        x, y = pos.value
        @@arr.each do |row|
            row.each do |el|
                row.delete(el) if @considered_positions.include?(el)
                moves << el if el == [x+1, y+2] ||
                el == [x+1, y-2] ||
                el == [x-1, y+2] || 
                el == [x-1, y-2] || 
                el == [x+2, y-1] ||
                el == [x+2, y+1] ||
                el == [x-2, y+1] ||
                el == [x-2, y-1]
            end
        end
        moves.each_with_index do |move, i|
            sandwhich = PolyTreeNode.new(move)
            sandwhich.parent = pos
            if !considered_positions.include?(sandwhich.value)
                @considered_positions << sandwhich.value 
            end 
            moves[i] = sandwhich 
        end 
        moves 
    end

    def find_path(end_pos)
       trace_path_back(@start.bfs(end_pos))
    end

    def trace_path_back(pos)
        arr = []
        while pos.parent
            arr << pos.value
            pos = pos.parent
        end
        arr << pos.value
    end
end 

knight = KnightPathFinder.new([1,1])
p knight.new_move_positions(knight.start)