function validPalindrome(input) {
	let recurse = (input, removeCharAllowed) => {
		// if 1st char != last char, then deleting one of those must
		// yield a palindrome
		// this can be generalized; by repeatedly comparing the 
		// 1st and last characters of smaller and smaller substrings
		
		// terminating conditions
		if (input === null || input.length <= 1) {
			return true;
		}
	
		let first = input.charAt(0);
		let last = input.charAt(input.length-1);
		if (first === last) {
			return recurse(input.slice(1, input.length-1), removeCharAllowed);
		}
		else if (!removeCharAllowed) {
			return false;
		}
	
		// remove either first or last and check if it results in a 
		// palindrome
		return (recurse(input.slice(1, input.length), false) ||
			recurse(input.slice(0, input.length-1), false));
	}
	
	return recurse(input, true);
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
test('aba');
test('abb');
test('abca');
test('a');
test('ab');
test('aa');
test('');
test(null);
test('abcdcbag');
