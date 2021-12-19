/* A linked list is said to contain a cycle if any node is visited more than once 
 * while traversing the list. Given a pointer to the head of a linked list, 
 * determine if it contains a cycle. If it does, return 1. Otherwise, return 0.
 * */
class SinglyLinkedListNode {
	constructor(data) {
		this.data = data;
	}
	set next(val) {
		this.nextPtr = val;
	}
	get next() {
		return this.nextPtr;
	}
}

// O(n) space, O(n) time
function hasCycle1(head) {
	let seenValues = new Set();
	let node = head;
	while (node) {
		if (seenValues.has(node.data)) {
			return 1;
		}
		seenValues.add(node.data);
		node = node.next;
	}
	return 0;
}

// O(1) space, O(n^2) time
function hasCycle2(head) {
	let node = head;
	while (node) {
		let reNode = head;
		while (reNode) {
			if (node.data === reNode.data)
				break;
			if (node.next && node.next.data === reNode.data)
				return 1;
			reNode = reNode.next;
		}
		node = node.next;
	}
	return 0;
}

// Floyd's algorithm, O(n) time, O(1) space
function hasCycle(head) {
	let slow = head;
	let fast = head;

	while (fast && fast.next) {
		slow = slow.next;
		fast = fast.next.next;
		console.log(`slow = ${slow.data}, fast = ${fast ? fast.data : 'null'}`);
		if (fast && fast.data === slow.data) {
			return 1;
		}
	}

	return 0;
}

function toString (head) {
	let node = head;
	let text = "[";
	let seenBefore = new Set();
	while (node) {
		text = text + node.data + " ";
		if (seenBefore.has(node.data)) {
			break;
		}
		seenBefore.add(node.data);
		node = node.next;
	}
	return text + "]";
}

function test(head) {
	console.log(`${toString(head)}, ${hasCycle(head)}`);
}

function createList(arr) {
	let head = null;
	let prevNode = null;
	let nodes = {};
	let node = null;
	arr.forEach((element, index) => {
		node = nodes[element];
		if (!node) {
			node = new SinglyLinkedListNode(element);
			nodes[element] = node;
		}
		else {

		}
		if (index === 0) {
			head = node;
		}
		if (prevNode !== null) {
			prevNode.next = node;
		}

		prevNode = node;
	});
	return head;
}

/*test(createList([1,2,3]));
test(createList([1,2,3,1]));
test(createList([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,2]));
test(createList([1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,14]));*/
test(createList([-21,10,17,8,4,26,5,35,33,-7,-16,27,-12,6,29,-12,5,9,20,14,14,2,13,-24,21,23,-21,5]));


