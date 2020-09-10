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

	def tree_predecessor(node)
		if (node.nil?)
			return nil
		end	
			
		# max of left subtree
		if node.left != nil
			return tree_max(node.left)
		end
		
		# or highest ancestor whose right child is also an ancestor of node;
		# go up tree until we encounter a node that is the right child of its parent
		x = node
		y = x.parent	
		while y != nil && y.left != nil && x.value == y.left.value do
			x = y
			y = y.parent
		end	
		return y
	end
	def tree_successor(node)
		if (node.nil?)
			return nil 
		end
		
		# min of right subtree
		if node.right != nil
			return tree_min(node.right)
		end
		
		# or lowest ancestor whose left child is also an ancestor of node;
		# go up tree until we encounter a node that is the left child of its parent
		x = node
		y = x.parent	
		while y != nil && y.right != nil && x.value == y.right.value do
			x = y
			y = y.parent
		end	
		
		return y		
	end
	def tree_insert(node, value)
		if node == nil
			@root = TreeNode.new(value, nil, nil, nil)
			return @root
		end
		
		if value < node.value
			if node.left == nil
				node.left = TreeNode.new(value, nil, nil, node)
				return node.left
			else
				return tree_insert(node.left, value)
			end
		elsif value > node.value
			if node.right == nil
				node.right = TreeNode.new(value, nil, nil, node)
				return node.right
			else
				return tree_insert(node.right, value)
			end
		else
			raise "Can't insert duplicate value"
		end
	end
	def tree_search(node, value)
		if node != nil
			if node.value == value
				return node
			end
			# TODO This is not right - need to go down either left or right subtree
			# based on value
			return tree_search(node.left, value) || tree_search(node.right, value)
		end
		return nil
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
				if is_root
					@root = nil
				elsif is_left_subnode
					parent.left = nil
				elsif is_right_subnode
					parent.right = nil
				end
						
			# node has one child
			elsif node.left == nil && node.right != nil  
				# replace node with child
				if is_root
					@root = node.right
				elsif is_left_subnode
					parent.left = node.right
				elsif is_right_subnode
					parent.right = node.right
				end
			elsif node.left != nil && node.right == nil
				if is_root
					@root = node.left
				elsif is_left_subnode
					parent.right = node.left
				elsif is_right_subnode
					parent.left = node.left
				end
			# node has two children	
			else
				# find successor and replace deleted node with it	
				parent = node.parent
				
				succ = tree_successor(node)	

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
	def tree_min(node)
		while node != nil
			if node.left == nil
				return node
			end
			node = node.left
		end	
		return nil
	end
	def tree_max(node)
		while node != nil
			if node.right == nil
				return node
			end
			node = node.right
		end
		return nil
	end
	def pre_order_traverse(node, action, depth)
		if node != nil
			action.call(node, depth)
			pre_order_traverse(node.left, action, depth + 1)
			pre_order_traverse(node.right, action, depth + 1)
		end
	end
	def in_order_traverse(node, action, depth)
		if node != nil
			in_order_traverse(node.left, action, depth + 1)
			action.call(node, depth)
			in_order_traverse(node.right, action, depth + 1)
		end
	end
	def post_order_traverse(node, action, depth)
		if node != nil
			post_order_traverse(node.left, action, depth + 1)
			post_order_traverse(node.right, action, depth + 1)
			action.call(node, depth)
		end
	end
	def print(order)
		f = order == "pre" ? pre_order_traverse : (order == "post" ? post_order_traverse : in_order_traverse)
		f(@root, lambda {|n, d| puts ("|" + "-" * d + "|" + n.value.to_s) }, 0)
	end

	private
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
	# replace node u with node v
	def transplant(u, v)
		if u.parent == nil
			@root = v
		elsif u == u.parent.left
			u.parent.left = v 
		else
			u.parent.right = v	
		end
		if v != nil
			v.parent = u.parent
		end	
	end
end