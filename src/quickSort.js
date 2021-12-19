/*
 * Complete the 'quickSort' function below.
 *
 * The function is expected to return an INTEGER_ARRAY.
 * The function accepts INTEGER_ARRAY arr as parameter.
 */
// O(n log n) time, O(N) space
function quickSort(arr) {
	if (!arr || arr.length <= 1) 
		return arr;
	if (arr.length === 2) {
		if (arr[0] <= arr[1])
			return arr;
		return [arr[1], arr[0]];
	}

	let pivot = arr[0];
	let left = [];
	let right = [];
	let equal = [pivot];
	for (let i=1; i<arr.length; i++) {
		if (arr[i] < pivot) {
			left.push(arr[i]);
		}
		else if (arr[i] === pivot) {
			equal.push(arr[i]);
		}
		else {
			right.push(arr[i]);
		}
	}

	return quickSort(left).concat(equal).concat(quickSort(right));
}

function log(arr) {
	if (typeof arr !== 'object' || arr === null) {
		console.log(arr); 
		return;
	}
	console.log(arr.reduce((prev, next) => (prev !== "" ? prev + " " : "") + next,""));
}

function test(arr) {
	console.log(`${JSON.stringify(arr)}, ${JSON.stringify(quickSort(arr))}`);
}

test(null);
test([]);
test([5]);
test([5,4]);
test([5,7,4,3,8]);
test([5,7,4,5,3,8]);
test([1,3,5,7,2,4,6,8]);
test([9,8,7,6,5,4,3,2,1]);
