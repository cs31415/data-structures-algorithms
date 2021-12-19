/*
 * Complete the 'insertionSort2' function below.
 *
 * The function accepts following parameters:
 *  1. INTEGER n
 *  2. INTEGER_ARRAY arr
 */
// O(n^2) time, O(1) space
function insertionSort2(arr) {
	if (!arr || arr.length < 2) { 
		log(arr);
		return arr;
	}

    for (let i=1; i<arr.length; i++) {
        insertIntoUnsorted(arr, i);
        log(arr);
    }

    return arr;
}

function insertIntoUnsorted(arr, k) {
	let unsorted = arr[k];
	let foundSpot = false;
	for (let i=k-1; i>=0; i--) {
		if (arr[i] <= unsorted) {
			arr[i+1] = unsorted;
			foundSpot = true;
			break;
		}
		arr[i+1] = arr[i];
	}	
	if (!foundSpot) {
		arr[0] = unsorted;
	}

	return arr;
}

function test(arr) {
	insertionSort2(arr);
}
function log(arr) {
	if (typeof arr !== 'object' || arr === null) {
		console.log(arr); 
		return;
	}
	console.log(arr.reduce((prev, next) => (prev !== "" ? prev + " " : "") + next,""));
}

test(null);
test([]);
test([1]);
test([2,1]);
test([1,3,2]);
test([1,2,4,5,3]);
test([1,2,4,5,2]);
test([2,3,4,5,6,7,8,9,10,1]);
test([5,4,3,2,1]);
test([1,4,3,5,6,2]);