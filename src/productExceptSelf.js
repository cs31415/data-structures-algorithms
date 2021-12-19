/* Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
 * */

function print(arr) {
	console.log('[' + arr.reduce((prev,cur) => prev + (prev !== '' ? ',' : '') + cur) + ']');
}

function productExceptSelf(nums) {
	let n = nums.length;

	let output = Array(n).fill(1);
	let down = nums[0];
	let up = nums[n-1];

	output[1] = down;
	if (n > 1) {
		output[n-2] = (n-2) === 1 ? down * up : up;
	}

	if (n > 2) {
		for (let i=2; i<n; i++) {
			down *= nums[i-1];
			output[i] *= down;
			
			up *= nums[n-i];
			output[n-1-i] *= up;
		}
	}
	print (nums);
	print (output); 
	console.log();

	return output;
}

let calls = 0;

//let nums = Array(10).fill().map((_, i) => i+1);
productExceptSelf([1,2,3,4]);
productExceptSelf([1,2,3,4,5,6,7,8]);
productExceptSelf([-1,1,0,-3,3]);
productExceptSelf([9,0,-2]);
productExceptSelf([1,2,3,-30]);
productExceptSelf([0,0]);
productExceptSelf([0]);


