#file linked_list.rb
require_relative 'linked_list'

class KeyValuePair
	attr_accessor :key, :value
	def initialize(key, value)
		@key = key
		@value = value
	end
end

class HashTable
	def initialize(size)
		# array of linked lists
		@arr = Array.new(size)
		@size = size
		puts "@arr.size = #{@arr.size}"
	end

	def add(key, value)
		puts "Adding {#{key}, #{value}}"
		# calculate hash function
		idx = hash(key)
		llist = @arr[idx]
		if llist == nil
			puts "Slot is empty. Put key value pair in slot"
			@arr[idx] = KeyValuePair.new(key, value)
		elsif llist.is_a?(KeyValuePair)
			puts "Slot has key value pair. Create linked list"
			# create linked list and add k,v pair to it
			# add linked list to arr[idx]
			llist = LinkedList.new()
			llist.add(@arr[idx])
			llist.add(KeyValuePair.new(key, value))
			@arr[idx] = llist
		else	
			puts "Slot has linked list. Add element to it"		
			llist.add(KeyValuePair.new(key, value))
		end
		puts "@arr.size = #{@arr.size}"
	end

	def get(key)
		val = nil
		idx = hash(key)
		if (@arr[idx] == nil)
		    return nil
		elsif (@arr[idx].is_a?(KeyValuePair))
			val = @arr[idx].value
		elsif (@arr[idx].is_a?(LinkedList))
			llist = @arr[idx]
			pair = llist.get(lambda {|p| p.key == key})
			if pair != nil && pair.is_a?(KeyValuePair)
				val = pair.value
			end
		end
		puts "h[#{key}] = #{val}"
		return val
	end

	def exists?(key)
		idx = hash(key)
		if (@arr[idx] == nil)
		    return false
		elsif (@arr[idx].is_a?(KeyValuePair))
			return true
		elsif (@arr[idx].is_a?(LinkedList))
			llist = @arr[idx]
			pair = llist.get(lambda {|p| p.key == key})
			if pair != nil
				return true
			else
				return false
			end
		end
		return false

	end

	def hash(key)
		return hash_division_method(key)
		#return hash_multiplication_method(key)
		#return universal_hashing_method(key)
	end

	def hash_division_method(key)
		puts "key = #{key}"
		position = key.length-1
		h = 0
		key.each_byte do |b|
			h = h + (b * 128**position)
			#puts "byte = #{b}, char = #{b.chr}, position = #{position}, #{128**position}, h = #{h}"
			position = position - 1
		end
		idx = h % @size
		puts "slot = #{idx}"
		return idx
	end

	def hash_multiplication_method(key)
		puts "key = #{key}"
		position = key.length-1
		a = 0.618033
		k = 0
		key.each_byte do |b|
			k = k + (b * 128**position)
			#puts "byte = #{b}, char = #{b.chr}, position = #{position}, #{128**position}, h = #{h}"
			position = position - 1
		end
		idx = (@size * (k*a % 1)).floor
		puts "slot = #{idx}"
		return idx
	end

	def universal_hashing_method(key)
		random_generator = Random.new
		hash_function = random_generator.rand(2)
		puts "hash_function = #{hash_function}"
		case hash_function
		when 0
			puts "Division method"
			return hash_division_method(key)
		when 1
			puts "Multiplication method"
			return hash_multiplication_method(key)
		end
	end
end


h = HashTable.new(4)
h.add("123456789",1)
h.add("def",2)
h.add("abd",3)
puts "h.exists?('b') = #{h.exists?("b")}"
h.get("def")
h.get("123456789")
h.add("x","xx")
h.add("y","yy")
h.get("x")
