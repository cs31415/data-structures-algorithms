/*
 * Complete the 'isBalanced' function below.
 *
 * The function is expected to return a STRING.
 * The function accepts STRING s as parameter.
 */

function isBalanced(s) {
	if (!s)
		return true;

	let isBalanced = true;
	let openBrackets = [];
	for (let i=0; i<s.length; i++) {
		switch(s[i]) {
			case '{':
			case '(':
			case '[':
				openBrackets.push(s[i]);
				break;
			case '}':
			case ')':
			case ']':
				let matchingOpenBracket = matchingBracket(s[i]);
				let lastOpenBracket = openBrackets.length > 0 ? openBrackets.pop() : null;
				if (lastOpenBracket !== matchingOpenBracket) {
					isBalanced = false;
				}
				//console.log(`s[${i}] = ${s[i]}, matchingOpenBracket = ${matchingOpenBracket}, lastOpenBracket = ${lastOpenBracket}, isBalanced = ${isBalanced}`);
				break;
		}
		if (!isBalanced)
			break;
	}

	// We came to the end and still had open brackets for which no corresponding
	// closing brackets were found.
	if (isBalanced && openBrackets.length > 0) {
		isBalanced = false;
	}
	
	return isBalanced;
}

function matchingBracket(b) {
	let brackets = {'}':'{', ')': '(', ']': '['};
	return brackets[b];
}

function test(s) {
	console.log(`${s}, ${isBalanced(s)}`);
}

test('{[()]}');
test('{[(])}');
test('{{[[(())]]}}');
test('');
test(null);
test('{]{]{]}]}]}');
test('{(([])[])[]]}');
test('((((((');
test(')))))');