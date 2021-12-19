/* 
 * 
 * Given a sorted list with an unsorted number in the rightmost cell, 
 * can you write some simple code to insert  into the array so that it 
 * remains sorted?
 *
 * e.g. [1,2,4,5,3]
 * */
function insertionSort1(arr) {
	if (!arr || arr.length < 2) { 
		log(arr);
		return arr;
	}

	let unsorted = arr[arr.length-1];
	let foundSpot = false;
	for (let i=arr.length-2; i>=0; i--) {
		if (arr[i] <= unsorted) {
			arr[i+1] = unsorted;
			foundSpot = true;
			break;
		}
		arr[i+1] = arr[i];
		log(arr);
	}	
	if (!foundSpot) {
		arr[0] = unsorted;
	}
	log(arr);
	return arr;
}

function test(arr) {
	insertionSort1(arr);
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