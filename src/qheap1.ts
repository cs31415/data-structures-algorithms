'use strict';

const fs = require('fs');
const es = require('event-stream');

class Heap {
    A: number[];
    isMaxHeap: boolean;

    constructor(isMaxHeap: boolean = true, A?: number[]) {
        this.A = A || new Array();
        this.isMaxHeap = isMaxHeap;
    }
    parent(i: number): number {
        return Math.floor(i/2);
    }
    left(i: number): number {
        return 2*i + 1;    
    }
    right(i: number): number {
        return 2*i + 2;
    }
    heapify(i: number) {
        //debug(`heapify(${i})`);
        let targetIdx = i;

        if (this.satisfiesCondition(this.A[this.left(i)], this.A[i])) 
            targetIdx = this.left(i);
        if (this.satisfiesCondition(this.A[this.right(i)], this.A[targetIdx])) 
            targetIdx = this.right(i);
        if (targetIdx !== i) {
            this.swap(targetIdx, i);
            this.heapify(targetIdx);
        }
    }
    satisfiesCondition(a: number, b: number): boolean {
        return this.isMaxHeap ? a > b : a < b;    
    }
    insert(key: number) {
        console.time("insert");
        this.A.push(key);
        for (let i=Math.floor(this.A.length/2)-1; i>=0; i--) {
            this.heapify(i);                                       
       }
       console.timeEnd("insert");
       //debug(`*insert ${key}, heap: ${this.A}`);
    }
    find(key: number, idx: number): number {
        let val: number = this.A[idx];
        if (key === val) {
            return idx;
        }
        let lVal: number = this.A[this.left(idx)];
        if (lVal === key) {
            return this.left(idx);
        }
        let rVal: number = this.A[this.right(idx)];
        if (rVal === key) {
            return this.right(idx);
        }
        if (!this.satisfiesCondition(lVal, key) && !this.satisfiesCondition(rVal, key)) {
            return -1;
        }
        let lFoundIdx = this.find(key, this.left(idx));
        if (lFoundIdx !== -1) {
            return lFoundIdx;
        }
        return this.find(key, this.right(idx));
    }
    delete(key: number) {
        console.time("delete");
        // find the key - O(N)
        console.time("find");    
        let deletedIdx: number = this.find(key, 0); 
        console.timeEnd("find");
        //debug(`*delete ${key}, deleted index = ${deletedIdx}`);
        if (deletedIdx === -1) {
            return;
        }

        // replace node with last node value except if the 
        // last node was the one that got deleted
        let lastIndexDeleted: boolean = deletedIdx === this.A.length-1;
        let lastVal: number = this.A.pop();
        if (!lastIndexDeleted) {
            this.A[deletedIdx] = lastVal;
        }

        // heapify node - O(log N)
        this.heapify(deletedIdx);
        //debug(`heap: ${this.A}`);
        console.timeEnd("delete");
    }
    getHead() {
        return this.A.length > 0 ? this.A[0] : null;
    }
    swap(i: number, j: number) {
        let tmp = this.A[i];
        this.A[i] = this.A[j];
        this.A[j] = tmp;
    }
}

process.stdin.resume();
process.stdin.setEncoding('utf-8');
let inputString: string = '';
let inputLines: string[] = [];
let currentLine: number = 0;
let heap: Heap = new Heap(false);

process.stdin.on('data', function(inputStdin: string): void {
//    inputString += inputStdin;
    processLine(heap, inputStdin);
});

process.stdin.on('end', function(): void {
//    inputLines = inputString.split('\n');
//    inputString = '';
//    main();
});

function readLine(): string {
    return inputLines[currentLine++];
}



function main() {
    let heap = new Heap(false);

    let lineNr = 0;
    var s = fs.createReadStream('./input0.txt')
        .pipe(es.split())
        .pipe(es.mapSync(function(inputLine){

            // pause the readstream
            s.pause();

            lineNr += 1;

            processLine(heap, inputLine);
            // process line here and call s.resume() when rdy
            // function below was for logging memory usage
            // resume the readstream, possibly from a callback
            s.resume();
        })
        .on('error', function(err){
            console.log('Error reading file.', err);
        })
        .on('end', function(){
            console.log(`Done. lineNr = ${lineNr}`);
        })
    );    
    
    if (!inputLines || inputLines.length <= 2) {
        return;
    }

    inputLines.forEach(inputLine => {
        processLine(heap, inputLine);        
    });
}
function processLine(heap: Heap, inputLine: string) {
    try {
        console.log(inputLine);
        if (!inputLine) {
            return;
        }

        let parts = inputLine.split(' ');
        let command = parts[0];
        let arg = null;
        if (command === '1' || command === '2') {
            if (parts.length < 2) {
                writeLine(`Invalid command: ${inputLine}`);
                return;
            }
            arg = parseInt(parts[1], 10);
        }
        switch (command) {
            case '1':
                heap.insert(arg);
                break;
            case '2':
                heap.delete(arg);
                break;
            case '3':
                writeLine(`${heap.getHead()}`);
                break;
            default:
                break;
        }
    }
    catch(e) {
        console.log(`ex in processLine: ${e}`);        
    }
}
function writeLine(msg: any) {
	process.stdout.write(msg + '\n');
}

function debug(msg: any) {
    //console.log(msg);
}

//main();