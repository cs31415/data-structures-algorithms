
/* input can be one of:
 * 1 x: Enqueue element  into the end of the queue.
 * 2: Dequeue the element at the front of the queue.
 * 3: Print the element at the front of the queue.
 * */

function processCommand(input) {
	let params = input && input.split(' ');
	if (!params || params.length === 0) {
		log('INVALID INPUT');
		return;
	}

	let cmd = parseInt(params[0], 10);
	if (!initialized) {
		numQueries = cmd;
		if (numQueries < 1) {
			log('INVALID NUMBER OF QUERIES');
			return;
		}
		initialized = true;
		return;
	}
	numQueries--;
	if (numQueries < 0) {
		log('EXCEEDED QUERY LIMIT');
		return;
	}

	if (cmd <1 || cmd >3) {
		log('INVALID COMMAND');
		return;
	}

	switch (cmd) {
		case 1:
			if (params.length < 2) {
				return 'MISSING INPUT ARG';
			} 
			let val = parseInt(params[1]);
			if (val < 1 || val > 10e9) {
				return 'INVALID ARG';
			}
			popAndPush(dstack, estack);
			estack.push(val);
			break;
		case 2:
			popAndPush(estack, dstack);
			dstack.pop();
			break;
		case 3:
			let front = null;
			if (dstack.length > 0) {
				front = dstack[dstack.length-1];
			}
			else if (estack.length > 0) {
				front = estack[0];
			}	
			log(front);
			break;
	}

	printQueue();
} 

function popAndPush(source, dest) {
	let elem = null;
	while (elem = source.pop()) {
		dest.push(elem);
	}
}

function printQueue() {
	if (estack.length > 0) {
		log(`estack: ${estack}`);
	}
	if (dstack.length > 0) {
		let q = 'dstack: [ ';
		for (let i=dstack.length-1; i>=0; i--) {
			q += dstack[i] + ','; 	
		}
		log(q + ' ]');
	}	
}

function log(s) {
	console.log(s);
}

function processData(input) {
	let inputs = input.split('\n');
	for (let i=0; i<inputs.length; i++) {
		log(`${inputs[i]}`);
		processCommand(inputs[i]);
	}
}

let numQueries = 0;
let initialized = false;
let estack = [];
let dstack = [];

processData('10\n1 42\n2\n1 14\n3\n1 28\n3\n1 60\n1 78\n2\n2');

