/*
 * Complete the 'rotLeft' function below.
 *
 * The function is expected to return an INTEGER_ARRAY.
 * The function accepts following parameters:
 *  1. INTEGER_ARRAY a
 *  2. INTEGER d
 */

function rotLeft(a, d) {
	let out = a.map(i => i);
	for (let i=0; i<d; i++) {
		let leftMost = out[0];
		for (let j=0; j<out.length-1; j++) {
			out[j] = out[j+1];
		}
		out[a.length-1] = leftMost;
	}
	return out;
}

function print(a) {
	console.log('[' + a.reduce((prev,next) => (prev ? (prev + ',') : prev) + next) + ']');
}

function test(a, d) {
	print(a);
	print(rotLeft(a, d));
}

test([1,2,3,4,5],4);
