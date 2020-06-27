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
		
		i = 0
		loop do
			idx = hash(key, i)
			if @arr[idx] == nil
				puts "Slot is empty. Put key value pair in slot"
				@arr[idx] = KeyValuePair.new(key, value)
				break
			else
				puts "Slot not empty. Go to next index"
				i = i + 1
			end
			if i == @arr.size
				puts "No empty slot found. Failed to add entry to table."
				break
			end
		end
		
		puts "@arr.size = #{@arr.size}"
	end

	def get(key)
		val = nil
		i = 0
		loop do
			idx = hash(key, i)
			if @arr[idx] == nil
				puts "Slot is empty. Key does not exist."
				break
			elsif @arr[idx].is_a?(KeyValuePair)
				if @arr[idx].key == key
					puts "Found key"
					val = @arr[idx].value
					break
				else
					puts "Slot not empty, but key didn't match. Go to next index"
					i = i + 1
				end
			else
				puts "Slot contains something other than a key value pair. Aborting."
				break
			end
			break if i == @arr.size
		end
	
		puts "h[#{key}] = #{val}"
		return val
	end

	def exists?(key)
		i = 0
		loop do
			idx = hash(key, i)
			if @arr[idx] == nil
				puts "Slot is empty. Key does not exist."
				return false
			elsif @arr[idx].is_a?(KeyValuePair)
				if @arr[idx].key == key
					puts "Found key"
					return true
				else
					puts "Slot not empty, but key didn't match. Go to next index"
					i = i + 1
				end
			else
				puts "Slot contains something other than a key value pair. Aborting."
				return false
			end
			break if i == @arr.size
		end
		return false
	end

	def hash(key, i)
		slot = hash_quadratic_probing(key, i)
		puts "slot = #{slot}"
		return slot
	end

	def hash_linear_probing(key, i)
		return (hash_division_method(key) + i) % @arr.size
	end

	def hash_quadratic_probing(key, i)
		c1 = 1
		c2 = 1
		return (hash_division_method(key) + c1*i + c2*i**2) % @arr.size
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
		return idx
	end

end


h = HashTable.new(8)
h.add("123456789",1)
h.add("def",2)
h.add("abd",3)
puts "h.exists?('b') = #{h.exists?("b")}"
h.get("def")
h.get("123456789")
h.add("a","a")
h.add("b","b")
h.add("c","c")
h.add("d","d")
h.add("e","e")
h.add("f","f")
