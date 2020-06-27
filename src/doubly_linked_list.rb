class LinkedList
	attr_accessor :head, :tail

	def add(value)
		newNode = Node.new(value, nil, @head)
		if @head == nil
			@tail = newNode
		else
			@head.prev = newNode
		end		
		@head = newNode
		puts "head = #{@head.value}, tail = #{@tail.value}"
	end

	def remove(value)
		puts "-- remove #{value}"
		node = @head
		prev = nil
		while node != nil
			if node.value == value
				puts "found it"
				if prev != nil
					prev.next = node.next
				else
					# removing head
					@head = node.next
				end
				if node.next != nil
					node.next.prev = prev
				else
					# removing tail
					@tail = node.prev
				end
			end
			prev = node
			node = node.next
		end
	end

	def get(predicate)
		node = @head
		while node != nil
			if predicate.call(node.value)
				return node.value
			end
			node = node.next
		end
		return nil	
	end

	def reverse
		puts "reverse list"
		node = @head
		while node != nil
			# swap the prev and next
			nextNode = node.next
			node.next = node.prev
			node.prev = nextNode
			
			#puts "value = #{node.value}, prev = #{node.prev != nil ? node.prev.value : 'nil'}, next = #{node.next != nil ? node.next.value : 'nil'}"
			
			node = nextNode
		end

		
		#swap the head and tail
		head = @head
		@head = @tail
		@tail = head
	end

	def printall
		puts "head = #{@head != nil ? @head.value : 'nil'}, tail = #{@tail != nil ? @tail.value : 'nil'}"

		node = @head
		print "nil "
		while node != nil
			print "< #{node.value != nil ? node.value : 'nil'} > "
			node = node.next
		end
		puts "nil"
	end
end

class Node
	attr_accessor :value, :prev, :next
	def initialize(value, prev, nxt)
		@value = value
		@prev = prev
		@next = nxt
	end
end

list = LinkedList.new
list.add(10)
list.add(20)
list.add(30)
list.printall
val = list.get lambda {|p| p == 10}
puts "val = #{val}"
list.reverse
list.printall
list.remove(20)
list.printall
list.remove(10)
list.printall
list.remove(30)
list.printall

