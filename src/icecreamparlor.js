/*
 * Complete the 'icecreamParlor' function below.
 *
 * The function is expected to return an INTEGER_ARRAY.
 * The function accepts following parameters:
 *  1. INTEGER m
 *  2. INTEGER_ARRAY arr
 */
// O(n^2) time, O(1) space
function icecreamParlor_slow(m, cost) {
	// for each flavor
	for (let i=0; i<cost.length-1; i++) {
		let item1Cost = cost[i];
		let item2Cost = m - item1Cost;	
		// is there another flavor that adds up to m?
		for (let j=i+1; j<cost.length; j++) {
			if (cost[j] === item2Cost) {
				return [i+1,j+1];
			}
		}
	}
	return [];
}

// O(n) time & space
function icecreamParlor(m, cost) {
	let position = {};
	for (let i=0; i<cost.length; i++) {
		let flavor1Cost = cost[i];
		if (flavor1Cost < m) {
			let balance = m - flavor1Cost;
			let j = position[balance.toString()];
			if (j !== undefined) {
				return [j+1, i+1];
			}

			// add the flavor's position to the flavors map
			position[flavor1Cost] = i;
		}
	}
	return [];
}


function test(m, cost) {
	console.log(`m = ${m}, cost = ${cost}, flavors = ${icecreamParlor(m, cost)}`);
}

test(4, [1,4,5,3,2]);
test(4, [2,2,4,3]);
