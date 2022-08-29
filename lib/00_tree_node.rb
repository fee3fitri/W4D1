class PolyTreeNode

    attr_reader :value, :children, :parent 

    def initialize(value)
        @parent =  nil
        @children = []
        @value = value 
    end 

    def parent=(node)
        @parent.children.delete(self) if self.parent != nil  
        return @parent = nil if node == nil

        @parent = node
        if parent.children.include?(self)
            return nil 
        end
        
        parent.children << self
    end

    def add_child(child_node)
        child_node.parent = self
    end

    def remove_child(child_node)
        raise "Error" if child_node.parent == nil
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if value == target_value
        
        children.each do |child|
            var = child.dfs(target_value)
            return var unless var.nil?
        end 
        nil 
    end

    def bfs(target_value)
        newarr = [self]
        
        until newarr.empty?
            popped = newarr.shift 
            return popped if popped.value  == target_value
            newarr += popped.children 
        end 
        nil 
    end 
end