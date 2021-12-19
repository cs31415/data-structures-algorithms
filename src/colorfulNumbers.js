/*3245 - (3 2 4 5, 32=6, 24=8, 45=20, 324=24, 245=40) => colorful
 *326 - (3 2 6, 32=6) => not colorful
 * */
// O(N) time, O(N) space
function isColorful(number) {
	if (!number)
		return false;

	let iterator = subsequences(number);
	let products = {};
	let subsequence = iterator.next();
	while(!subsequence.done) {
		let product = subsequence.value.split('').reduce((prev,next) => prev*parseInt(next,10), 1);
		if (product in products)
			return false;
		products[product] = 1;
		subsequence = iterator.next();
	}
	return true;
}

function * subsequences(number) {
	let strNumber = number.toString();
	let ndigits = strNumber.length;
	for (let i=1; i<=ndigits; i++) {
		// subsequences of i digits
		for (let j=0; j<ndigits-i+1; j++) {
			let num = strNumber.substring(j,j+i);
			yield num;
		}
	}
}

function test(number) {
	console.log(`${number}, ${isColorful(number)}`);
}

test(0);
test(null);
test(23);
test(3245);
test(3246);
test(326);
