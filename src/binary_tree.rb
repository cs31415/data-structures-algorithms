class TreeNode
	attr_accessor :value, :left, :right, :parent
	def initialize(value, left, right, parent)
		@value = value
		@left = left
		@right = right
		@parent = parent
	end
end

class BinaryTree
	attr_accessor :root

	def insert(value)
		if @root == nil
			@root = TreeNode.new(value, nil, nil, nil)	
		else
			tree_insert(@root, value)			    
		end
	end
	def search(value) 		
		node = tree_search(@root, value)
		puts "search(#{value}) = #{node != nil ? 'true' : 'false'}"
		return node
	end
	def remove(value)
		node = tree_search(@root, value)
		tree_remove(node)	
	end
	def min(node)
		while node != nil
			if node.left == nil
				return node
			end
			node = node.left
		end	
		return nil
	end
	def max(node)
		while node != nil
			if node.right == nil
				return node
			end
			node = node.right
		end
		return nil
	end
	def predecessor(value)
		node = search(value)
		pred = tree_predecessor(node)	
		puts "predecessor(#{value}) = #{pred != nil ? pred.value : 'nil'}"
		return pred
	end
	def successor(value)
		node = tree_search(@root, value)
		succ =  tree_successor(node)
		puts "successor(#{value}) = #{succ != nil ? succ.value : 'nil'}"
		return succ
	end
	def pre_order_traverse(node, action, depth, dir)
		if node != nil
			action.call(node, depth, dir)
			pre_order_traverse(node.left, action, depth + 1, "l")
			pre_order_traverse(node.right, action, depth + 1, "r")
		end
	end
	def in_order_traverse(node, action, depth)
		if node != nil
			in_order_traverse(node.left, action, depth + 1)
			action.call(node, depth)
			in_order_traverse(node.right, action, depth + 1)
		end
	end
	def post_order_traverse(node, action)
	end
	def print()
		pre_order_traverse(@root, lambda {|n, d, r| puts ("." * d + n.value.to_s + "-" + (r != nil ? r : "")) }, 0, nil)
	end

	private
	def tree_predecessor(node)
		if node != nil && node.left != nil
			return max(node.left)
		end
		value = node != nil ? node.value : nil
		while node != nil
			# predecessor can either be the left child or 
			# 1st ancestor whose value is less than node
			if node.parent != nil && node.parent.value < value
				return node.parent
			end
			node = node.parent
		end
		return nil
	end
	def tree_successor(node)
		if node != nil && node.right != nil
			return min(node.right)
		end
		value = node != nil ? node.value : nil
		while node != nil
			if node.parent != nil && node.parent.value > value
				return node.parent
			end
			node = node.parent
		end
		return nil		
	end
	def tree_insert(node, value)
		if value < node.value
			if node.left == nil
				node.left = TreeNode.new(value, nil, nil, node)
			else
				tree_insert(node.left, value)
			end
		elsif value > node.value
			if node.right == nil
				node.right = TreeNode.new(value, nil, nil, node)
			else
				tree_insert(node.right, value)
			end
		else
			puts "Can't insert duplicate value"
		end
	end
	def is_left_subnode(node)
		if node != nil
			parent = node.parent
			return parent.left == node
		end
		return false
	end
	def is_right_subnode(node)
		if node != nil
			parent = node.parent
			return parent.right == node
		end
		return false
	end
	def tree_remove(node)
		if node != nil						
			parent = node.parent
			if parent == nil
				# this must be the root node
				is_root = true
			else
				is_left_subnode = is_left_subnode(node)
				is_right_subnode = is_right_subnode(node)
			end
			# node has no children
			if node.left == nil && node.right == nil
				puts "node has no children"
				if is_root
					@root = nil
				elsif is_left_subnode
					parent.left = nil
				elsif is_right_subnode
					parent.right = nil
				end
						
			# node has one child
			elsif node.left == nil && node.right != nil  
				puts "node has one right child"
				# replace node with child
				if is_root
					@root = node.right
				elsif is_left_subnode
					parent.left = node.right
				elsif is_right_subnode
					parent.right = node.right
				end
			elsif node.left != nil && node.right == nil
				puts "node has one left child"
				if is_root
					@root = node.left
				elsif is_left_subnode
					parent.right = node.left
				elsif is_right_subnode
					parent.left = node.left
				end
			# node has two children	
			else
				puts "node has two children"
				# find successor and replace deleted node with it	
				parent = node.parent
				
				succ = tree_successor(node)	
				puts "successor = #{succ.value}"

				# succ.left will always be nil
				if succ.left != nil
					puts "succ.left is not nil. #problem"
				end
				is_succ_left_subnode = is_left_subnode(succ)

				if is_succ_left_subnode
					succ.parent.left = succ.right != nil ? succ.right : nil
				else
					succ.parent.right = succ.right != nil ? succ.right : nil
				end
			
				succ.left = node.left
				succ.right = node.right
				
				if is_root
					@root = succ
				elsif is_left_subnode
					parent.left = succ
				elsif is_right_subnode
					parent.right = succ
				end

			end
		end
	end
	def tree_search(node, value)
		if node != nil
			if node.value == value
				return node
			end
			return tree_search(node.left, value) || tree_search(node.right, value)
		end
		return nil
	end
end

t = BinaryTree.new()
t.insert(20)
t.insert(10)
t.insert(15)
t.insert(13)
t.insert(11)
t.insert(12)
t.insert(14)
t.insert(30)
t.insert(50)
t.insert(60)
t.insert(9)
t.print()
t.search(30)
t.search(80)
t.search(60)
t.search(20)
puts "min = #{t.min(t.root).value}"
puts "max = #{t.max(t.root).value}"
t.predecessor(50)
t.predecessor(20)
t.predecessor(60)
t.predecessor(30)
t.predecessor(10)
t.predecessor(80)
t.predecessor(11)
t.predecessor(12)
t.predecessor(13)
t.predecessor(14)
t.predecessor(15)

t.successor(50)
t.successor(20)
t.successor(60)
t.successor(30)
t.successor(10)
t.successor(80)
t.successor(11)
t.successor(12)
t.successor(13)
t.successor(14)
t.successor(15)

puts "Removing 12"
t.remove(12)
t.print()


puts "Removing 14"
t.remove(14)
t.print()

puts "Removing 10"
t.remove(10)
t.print()

puts "Removing 20"
t.remove(20)
t.print()


