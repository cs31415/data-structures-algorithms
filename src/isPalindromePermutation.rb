def getPermutations(input)
	#puts "getPermutations (#{input})"
	if input == nil or input.empty?
		return ['']
	end
	if (input.length == 2)
		#puts "2: [#{input}, #{input.reverse}]"
		return [input, input.reverse]
	end
	permutations = Array.new
	for i in 0..input.length-1
		rest = input.slice(0,i) + input.slice(i+1,input.length)
		#puts "i = #{i}, first = #{input[i]}, rest = #{rest}"
		permutations.concat(getPermutations(rest).map{|x| "#{input[i]}#{x}"})	
	end		
	return permutations
end

def isPalindrome(input)
	success = true
	ri = input.length-1
	for i in 0..input.length/2-1
		if (input[i] != input[ri-i]   && 
		   !input[i].strip.empty?     && 
		   !input[ri-i].strip.empty?)
			success = false
			break
		end
	end
	return success
end

def isPalindromePermutation(input)
	getPermutations(input).select {|x| isPalindrome(x)}.length > 0
end

puts "Enter input:"
input = gets.chomp
#perms = getPermutations(input).select{|x| isPalindrome(x)}
#puts "** #{perms.length} permutations"
#perms.map {|x| puts x}
puts isPalindromePermutation(input)
