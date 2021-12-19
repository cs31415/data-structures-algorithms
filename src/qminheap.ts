'use strict';

class Heap {
    A: number[];

    constructor(A?: number[]) {
        this.A = A || new Array();
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
        let lIdx = this.left(i);
        let rIdx = this.right(i);
        let heapSize = this.A.length;

        if (lIdx <= heapSize - 1 && this.A[lIdx] < this.A[i]) 
            targetIdx = lIdx;
        if (rIdx <= heapSize - 1 && this.A[rIdx] < this.A[targetIdx]) 
            targetIdx = rIdx;
        if (targetIdx !== i) {
            this.swap(targetIdx, i);
            this.heapify(targetIdx);
        }
        //debug(`heap: ${this.A}`);
    }
    insert(key: number) {
        //console.time("insert");
        if (key < this.A[0]) {
            this.A.unshift(key);
        }
        else {
            this.A.push(key);
            // if the element we just pushed is greater than the one preceding it,
            // no need to heapify
            for (let i=Math.floor(this.A.length/2)-1; i>=0; i--) {
                this.heapify(i);                                       
            }
        }
       //console.timeEnd("insert");
       //debug(`*insert ${key}, heap: ${this.A}`);
    }
    find(key: number, idx: number): number {
        let val: number = this.A[idx];
        if (key === val) {
            return idx;
        }
        let lIdx = this.left(idx);
        let lVal: number = this.A[lIdx];
        if (lVal === key) {
            return lIdx;
        }
        let rIdx = this.right(idx);
        let rVal: number = this.A[rIdx];
        if (rVal === key) {
            return rIdx;
        }
        if (!(lVal < key) && !(rVal < key)) {
            return -1;
        }
        let lFoundIdx = this.find(key, lIdx);
        if (lFoundIdx !== -1) {
            return lFoundIdx;
        }
        return this.find(key, rIdx);
    }
    delete(key: number) {
        //console.time("delete");
        // find the key - O(N)
        //console.time("find");    
        let deletedIdx: number = this.find(key, 0); 
        //console.timeEnd("find");
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
            this.heapify(deletedIdx);
        }

        // heapify node - O(log N)
        //debug(`delete ${key}, heap: ${this.A}`);
        //console.timeEnd("delete");
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

let inputLines: string[] = [];
let currentLine: number = 0;
let inputString: string = '';
let heap: Heap = new Heap();

process.stdin.resume();
process.stdin.setEncoding('utf-8');
process.stdin.on('data', function(inputStdin: string): void {
//    inputString += inputStdin;
    processLine(heap, inputStdin.split('\n')[0]);
});

process.stdin.on('end', function(): void {
//    inputLines = inputString.split('\n');
//    inputString = '';
//    main();
});

/*const fs = require('fs');
const es = require('event-stream');

function main() {
    processFile('./input.txt');       
}

function processFile(fileName: string) {
    var s = fs.createReadStream(fileName)
        .pipe(es.split())
        .pipe(es.mapSync(function(inputLine: string) {

            // pause the readstream
            s.pause();

            processLine(heap, inputLine);
            // process line here and call s.resume() when rdy
            // function below was for logging memory usage
            // resume the readstream, possibly from a callback
            s.resume();
        })
        .on('error', function(err: string){
            console.log('Error reading file.', err);
        })
        .on('end', function(){
            console.log(`Done.`);
        })
    ); 
}*/

function processLine(heap: Heap, inputLine: string) {
    try {
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
        writeLine(`ex in processLine: ${e}`);        
    }
}
function writeLine(msg: any) {
	process.stdout.write(msg + '\n');
}

function debug(msg: any) {
    console.log(msg);
}

//main();