function validPalindrome(input) {
	let recurse = (input, i, j, removeCharAllowed) => {
		log(`recurse ${i}, ${j}, ${removeCharAllowed}`);
		// if 1st char != last char, then deleting one of those must
		// yield a palindrome
		// this can be generalized; by repeatedly comparing the 
		// 1st and last characters of smaller and smaller substrings
		
		// terminating conditions

		if (j-i < 2) {
			return true;
		}
	
		for (let left=i, right=j; left<right; left++, right--) {
			let first = input[left];
			let last = input[right-1];
			log(`first = ${first}, last = ${last}`);
			if (first !== last) {
				if (!removeCharAllowed)
					return false;
				
				// remove either first or last and check if it results in a 
				// palindrome
				return (recurse(input, left+1, right, false) || recurse(input, left, right-1, false));
			}
		}
		return true;
	}
	
	return recurse(input, 0, input !== null ? input.length : 0, true);
}

function log(input) {
	//console.log(input);
}

function test(input) {
	console.log(`${input}, ${validPalindrome(input)}`);
}
test('madam');
test('madamimadam');
test('abc');
test('abcdef');
test('aba');
test('abb');
test('abca');
test('a');
test('ab');
test('aa');
test('');
test(null);
test('abcdcbag');
