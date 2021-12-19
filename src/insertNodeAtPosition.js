/*
 * Complete the 'insertNodeAtPosition' function below.
 *
 * The function is expected to return an INTEGER_SINGLY_LINKED_LIST.
 * The function accepts following parameters:
 *  1. INTEGER_SINGLY_LINKED_LIST llist
 *  2. INTEGER data
 *  3. INTEGER position
 */

/*
 * For your reference:
 *
 * SinglyLinkedListNode {
 *     int data;
 *     SinglyLinkedListNode next;
 * }
 *
 */
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

function insertNodeAtPosition(head, data, position) {
	if (head === null)
		return null;
	
	let node = head;
	let prevNode = null;
	let currentPosition = 0;
	let inserted = false;
	while (node) {
		if (currentPosition === position) {
			let newNode = new SinglyLinkedListNode(data);
			newNode.next = node;
			if (prevNode === null) {
				head = newNode;
			}
			else {
				prevNode.next = newNode;
			}	
			inserted = true;
			break;
		}
		
		prevNode = node;
		node = node.next;
		currentPosition++;
	}

	if (!inserted) {
		if (position >= currentPosition) {
			let newNode = new SinglyLinkedListNode(data);
			newNode.next = null;
			prevNode.next = newNode;
		}
	}

	return head;
}

function toString (head) {
	let node = head;
	let text = "[";
	while (node) {
		text = text + node.data + " ";
		node = node.next;
	}
	return text + "]";
}

function test(head, data, position) {
	console.log(`${toString(head)}, ${data}, ${position}`);
	console.log(`${toString(insertNodeAtPosition (head, data, position))}`)
}

function createList(arr) {
	let head = null; 
	let prevNode = null;
	arr.forEach((element, index) => {
		let node = new SinglyLinkedListNode(element);
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

test(createList([1,2,3]), 4, 2);
test(createList([1,2,3]), 4, 0);
test(createList([1,2,3]), 4, 1);
test(createList([1,2,3]), 4, 3);
test(createList([1,2,3]), 4, 4);
