class LinkedList
	attr_accessor :head

	def add(value)
		# adds to head of list
		newNode = Node.new(value, @head)
		@head = newNode
	end

	def contains(value)
		node = @head
		while node != nil do
			if node.value == value
				return true
			end
			node = node.next
		end
		return false
	end

	def remove(value)
		node = @head
		while node != nil do
			if node.value == value
				# remove the node and adjust pointers
				if prev == nil
					# we're at the head. Reset head to the next node.
					@head = node.next
				else
					prev.next = node.next
				end
			else
				# move to next node
				node = node.next
			end
			prev = node
		end
	end

	def get(predicate)
		node = @head
		while node != nil do
			if predicate.call(node.value)
				return node.value
			end
			node = node.next
		end
		return nil
	end

	def reverse
		# O(n) time, O(1) space
		prevNode = nil
		node = @head
		while node != nil do
			puts "node = #{node.value}, next = #{node.next == nil ? 'nil' : node.next.value}"
			# save next node
			nextNode = node.next
			
			# set next to prev node
			node.next = prevNode

			# if we reached end of list, reset the head
			# to this node
			if nextNode == nil
				puts "Reached end of list. Resetting head."
				@head = node
				break
			end
			
			# save current as prev for next iteration
			prevNode = node

			# move to the next node
			node = nextNode
		end
	end

	def write
		node = @head
		while node != nil do
			print "#{node.value.to_s} > "
			node = node.next
		end
		puts "nil"
	end
end

class Node
	attr_accessor :value, :next
	def initialize(value, nxt)
		@value = value
		@next = nxt
	end
end

def test
	list = LinkedList.new
	list.add(10)
	list.add(30)
	list.add(20)
	list.write

	puts list.contains(20)
	puts list.contains(30)
	puts list.contains(40)
	puts list.contains("abc")
	list.reverse
	list.write
end

# test