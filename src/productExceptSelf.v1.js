/* Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
 * */

function print(arr, desc) {
	arr.forEach((x,i) => console.log(`${desc}[${i}] = ${arr[i]}`));
}

function productExceptSelf(nums) {
	let hash = {};
	let product = (prev, cur) => {
		console.log(`product (${prev}, ${cur})`);
		let key = prev < cur ? `${prev}.${cur}` : `${cur}.${prev}`;
		if (!(key in hash)) {
			hash[key] = prev * cur;
		}
		else {
			console.log(`cache hit for key ${key}`);
		}
		return hash[key];
	};
	
	let output = Array(nums.length).fill();
	nums.forEach((_,i) => {
		calls++;
		
		output[i] = nums.reduce((prev, cur, idx) => idx !== i ? product(prev,cur) : prev, 1);
	});

	return output;
}

let calls = 0;

//let nums = Array(10).fill().map((_, i) => i+1);
let nums = [1,2,3,4];
//let nums = [-1,1,0,-3,3];
console.log(`nums.length = ${nums.length}`);
print(nums, 'nums');

let output = productExceptSelf(nums);
print(output, 'output');

console.log(`TOTAL CALLS = ${calls}`);
