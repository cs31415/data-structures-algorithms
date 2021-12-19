/*
 * Complete the 'designerPdfViewer' function below.
 *
 * The function is expected to return an INTEGER.
 * The function accepts following parameters:
 *  1. INTEGER_ARRAY h
 *  2. STRING word
 */

function designerPdfViewer(h, word) {
	let offset = "a".charCodeAt();
	let maxHeight = 0;
	let width = word.length;

	for (let i=0; i<width; i++) {
		let index = word[i].charCodeAt() - offset;
		if (h[index] > maxHeight)
			maxHeight = h[index];
	} 
	return maxHeight * width;
}

function test(h, word) {
	console.log(`${word}, area = ${designerPdfViewer(h, word)}`);
}

let h = [1,3,1,3,1,4,1,3,2,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,5,7];
test(h, 'zaba');

h = [1,3,1,3,1,4,1,3,2,5,5,5,5,1,1,5,5,1,5,2,5,5,5,5,5,5];
test(h, 'torn');

