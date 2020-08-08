require_relative "../binary_tree"
require "rspec"

describe BinaryTree, "#insert" do
	context "insert into empty tree" do
		it "inserts root node" do
			t = BinaryTree.new()
			node = t.tree_insert(nil, 20)
			expect(node.value).to eq t.root.value
		end
	end
	context "insert value less than root node" do
		it "inserts into left subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			node = t.tree_insert(root, 10)
			expect(node.value).to eq t.root.left.value
			expect(node.left).to eq nil 
			expect(node.right).to eq nil 
		end
	end
	context "insert value greater than root node" do
		it "inserts into right subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			node = t.tree_insert(root, 30)
			expect(node.value).to eq t.root.right.value
			expect(node.left).to eq nil 
			expect(node.right).to eq nil 
		end
	end
	context "insert value less than 1st left child" do
		it "inserts into left child's left subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			left_child = t.tree_insert(root, 10)
			node = t.tree_insert(left_child, 5)
			expect(node.value).to eq left_child.left.value
			expect(node.left).to eq nil 
			expect(node.right).to eq nil 
		end
	end
	context "insert value greater than 1st left child" do
		it "inserts into left child's right subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			left_child = t.tree_insert(root, 10)
			node = t.tree_insert(left_child, 15)
			expect(node.value).to eq left_child.right.value
			expect(node.left).to eq nil 
			expect(node.right).to eq nil 
		end
	end
	context "insert value less than 1st right child" do
		it "inserts into right child's left subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			right_child = t.tree_insert(root, 30)
			node = t.tree_insert(right_child, 25)
			expect(node.value).to eq right_child.left.value
			expect(node.left).to eq nil 
			expect(node.right).to eq nil 
		end
	end
	context "insert value greater than 1st right child" do
		it "inserts into right child's right subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			right_child = t.tree_insert(root, 10)
			node = t.tree_insert(right_child, 15)
			expect(node.value).to eq right_child.right.value
			expect(node.left).to eq nil 
			expect(node.right).to eq nil 
		end
	end
end

describe BinaryTree, "#search" do
	context "value equals root node" do
		it "returns root node" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			node = t.tree_search(root, 20)
			expect(node.value).to eq t.root.value
		end
	end
	context "value equals left subtree intermediate node" do
		it "returns root node" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)	
			node = t.tree_search(root, 10)
			expect(node.value).to eq 10
		end
	end
	context "value equals right subtree intermediate node" do
		it "returns root node" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 25)
			t.tree_insert(root, 35)	
			node = t.tree_search(root, 30)
			expect(node.value).to eq 30
		end
	end
	context "value equals left subtree leaf node" do
		it "returns root node" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)	
			node = t.tree_search(root, 15)
			expect(node.value).to eq 15
		end
	end
	context "value equals right subtree leaf node" do
		it "returns root node" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 25)
			t.tree_insert(root, 35)	
			node = t.tree_search(root, 25)
			expect(node.value).to eq 25
		end
	end
end

describe BinaryTree, "#remove" do
	context "value equals root node" do
		it "removes root node and replaces with successor" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)

			t.tree_remove(root)
			expect(30).to eq t.root.value
		end
	end
	context "value equals left subtree intermediate node" do
		it "replaces node with successor" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			node = t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)	
			parent = node.parent

			t.tree_remove(node)
			
			expect(parent.left.value).to eq 15
		end
	end
	context "value equals right subtree intermediate node" do
		it "replaces node with successor" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			node = t.tree_insert(root, 30)
			t.tree_insert(root, 25)
			t.tree_insert(root, 35)	
			parent = node.parent

			t.tree_remove(node)
			
			expect(parent.right.value).to eq 35
		end
	end
	context "value equals left subtree leaf node" do
		it "removes node and replaces parent link with null" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			node = t.tree_insert(root, 15)	
			parent = node.parent

			t.tree_remove(node)
			
			expect(parent.right).to eq nil
		end
	end
	context "value equals right subtree leaf node" do
		it "removes node and replaces parent link with null" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			node = t.tree_insert(root, 25)
			t.tree_insert(root, 35)	
			parent = node.parent

			t.tree_remove(node)
			
			expect(parent.left).to eq nil
		end
	end
end

describe BinaryTree, "#predecessor" do
	context "no left subtree" do
		it "returns highest ancestor whose right child is an ancestor" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)
			node = t.tree_insert(root, 12)
			t.tree_insert(root, 17)

			pred = t.tree_predecessor(node)

			expect(pred.value).to eq 10
		end
	end
	context "has left subtree" do
		it "returns max node in left subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)
			t.tree_insert(root, 12)
			t.tree_insert(root, 17)

			pred = t.tree_predecessor(root)

			expect(pred.value).to eq 17
		end
	end
end

describe BinaryTree, "#successor" do
	context "no right subtree" do
		it "returns lowest ancestor whose left child is an ancestor" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)
			t.tree_insert(root, 12)
			node = t.tree_insert(root, 17)

			succ = t.tree_successor(node)	

			expect(succ.value).to eq 20
		end
	end
	context "has right subtree" do
		it "returns min node in right subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			node = t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)
			t.tree_insert(root, 12)
			t.tree_insert(root, 17)

			succ = t.tree_successor(node)

			expect(succ.value).to eq 12
		end
	end
end

describe BinaryTree, "#min" do
	context "no left subtree" do
		it "returns node" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 30)

			tmin = t.tree_min(root)	

			expect(tmin.value).to eq 20
		end
	end
	context "has left subtree" do
		it "returns leftmost node with no left link in left subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			node = t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)
			t.tree_insert(root, 12)
			t.tree_insert(root, 17)

			tmin = t.tree_min(root)

			expect(tmin.value).to eq 5
		end
	end
end
describe BinaryTree, "#max" do
	context "no right subtree" do
		it "returns node" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			t.tree_insert(root, 10)

			tmax = t.tree_max(root)	

			expect(tmax.value).to eq 20
		end
	end
	context "has right subtree" do
		it "returns rightmost node with no right link in right subtree" do
			t = BinaryTree.new()
			root = t.tree_insert(nil, 20)
			node = t.tree_insert(root, 10)
			t.tree_insert(root, 30)
			t.tree_insert(root, 25)
			t.tree_insert(root, 35)
			t.tree_insert(root, 5)
			t.tree_insert(root, 15)
			t.tree_insert(root, 12)
			t.tree_insert(root, 17)

			tmax = t.tree_max(root)

			expect(tmax.value).to eq 35
		end
	end
end