'use strict';

import { debug } from "console";

process.stdin.resume();
process.stdin.setEncoding('utf-8');
let inputString: string = '';
let inputLines: string[] = [];
process.stdin.on('data', function(inputStdin: string): void {
    inputString += inputStdin;
});

process.stdin.on('end', function(): void {
    inputLines = inputString.split('\n');
    inputString = '';
    main();
});

interface ITNode {
	left: ITNode;
	right: ITNode;
	data: number;
}

class TNode {
	left: ITNode;
	right: ITNode;
	data: number;

	constructor(data: number) {
		this.data = data;
		this.left = null;
		this.right = null;
	}
}

function preOrder(root: ITNode, visit: (node: ITNode) => void) {
	if (root === null)
		return;

	visit(root);
	
	preOrder(root.left, visit);
	preOrder(root.right, visit);
}

function printTree(root: ITNode) {
	preOrder(root, (node: ITNode):void => { write(node.data + ' '); });
	writeLine('');
}

// O(n) time, O(1) space
function binaryTreeHeight(root: ITNode) : number {
    let maxHeight = 0;
    
    function calculateHeight(node: ITNode, height: number) : void {
        if (node === null)
            return;

        // We are at a leaf node; update maxHeight if required
        if (node.left === null && node.right === null) {
            debug(`leaf node value = ${node.data}, height = ${height}`);
            if (height > maxHeight) {
                maxHeight = height; 
            }      
            return; 
        }

        calculateHeight(node.left, height+1);
        calculateHeight(node.right, height+1);
    }

    calculateHeight(root, 0);

    return maxHeight;
}

function main() {
    if (!inputLines || inputLines.length <= 2) {
		return;
	}

	let values: number[] = inputLines[1].split(' ').map(s => parseInt(s, 10));
	let root: ITNode = null;
	
	for (let i=0; i<values.length; i++) {
		root = insert(root, values[i]);
	}	

	printTree(root);
    writeLine(binaryTreeHeight(root));

    return root;
}

function insert(root: ITNode, data: number): ITNode {
	function tryInsert(current: ITNode): ITNode {
		if (root === null)
			return new TNode(data);
			
		if (data < current.data) {
			if (current.left === null) {
				current.left = new TNode(data);
			}
			else
				tryInsert(current.left);
		}
		else {
			if (current.right === null) {
				current.right = new TNode(data);
			}
			else
				tryInsert(current.right);
		}

		return root;
	}
	
	let nRoot: ITNode = tryInsert(root);

	return root === null ? nRoot : root;
}

function write(msg: any) {
	process.stdout.write(msg);
}

function writeLine(msg: any) {
	process.stdout.write(msg + '\n');
}
