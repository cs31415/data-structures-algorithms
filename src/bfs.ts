'use strict';

import { Hash } from "crypto";
import { WriteStream, createWriteStream } from "fs";
import { fileURLToPath } from "url";
const fs = require('fs');
const es = require('event-stream');

process.stdin.resume();
process.stdin.setEncoding('utf-8');

let inputString: string = '';
let inputLines: string[] = [];
let currentLine: number = 0;

Map.prototype.toString = function () { 
	return JSON.stringify(Array.from(this.entries()));	
}

process.stdin.on('data', function(inputStdin: string): void {
    inputString += inputStdin;
});

process.stdin.on('end', function(): void {
    inputLines = inputString.split('\n');
    inputString = '';

    main();
});

function readLine(): string {
    return inputLines[currentLine++];
}

function addEdge(vertices: Map<number, number[][]>, v1: number, v2: number, weight: number) {
    let adjList = vertices.get(v1);

    adjList.push([v2, weight]); 
}

/*
 * Complete the 'bfs' function below.
 *
 * The function is expected to return an INTEGER_ARRAY.
 * The function accepts following parameters:
 *  1. INTEGER n
 *  2. INTEGER m
 *  3. 2D_INTEGER_ARRAY edges
 *  4. INTEGER s
 */
function bfs(n: number, m: number, edges: number[][], s: number): number[] {
    //console.log(`bfs (n:${n}, m:${m}, edges.length = ${edges.length}, s:${s})`);

    // build the graph using adjacency list representation
    let color: Map<number, string> = new Map();
    let d: Map<number, number> = new Map();
    let prev: Map<number, number> = new Map();
    let vertices: Map<number, number[][]> = new Map();
    let edgeWeight: number = 6;

    // add vertices
    Array.from({length: n}, (_, i) => i+1).forEach(vertex => {
        vertices.set(vertex, []);
    });    

    // add edges
    edges.forEach(edge => {
        let v1 = edge[0];
        let v2 = edge[1];

        addEdge(vertices, v1, v2, edgeWeight);
        addEdge(vertices, v2, v1, edgeWeight);
    });

    // initialize color and d collections
    // for each vertex:
    //      color[vertex] = "white"
    //      d[vertex] = -1
    //      prev[vertex] = null
    vertices.forEach((value: number[][], vertex: number) => {
        color.set(vertex, 'white');
        d.set(vertex, vertex === s ? 0 : -1);
        prev.set(vertex, null);
    });

    // do a breadth first search with start node s;
    // add s to the queue
    // while queue not empty
    //      node = dequeue(Q) 
    //      color[node] = if gray then black else if white then gray
    //      add each node in node's adjacency list to Q
    //      
    let q: number[] = [];
    q.push(s);
    let dParent = 0;

    while (q.length > 0){
        // dequeue 
        let vertex = q.shift();
        color.set(vertex, color.get(vertex) === 'white' ? 'gray' : 'black');
        dParent = d.get(vertex);
        let adjList = vertices.get(vertex);

        adjList.forEach(element => {
            let v = element[0];
            let weight = element[1];

            if (color.get(v) !== 'black') {    
                color.set(v, color.get(v) === 'white' ? 'gray' : 'black');
                let distance = d.get(v) > -1 ? Math.min(d.get(v), weight + dParent) : weight + dParent;
                d.set(v, distance);
                prev.set(v, vertex);
                q.push(v);
            }
        });  

        color.set(vertex, 'black');  
    }
    
    //console.log(`color = ${color}`);
    //console.log(`d = ${d}`);
    //console.log(`prev = ${prev}`);

    let rslt: number[] = [];
    d.forEach((val: number, vertex: number) => {
        if (vertex !== s)
            rslt.push(d.get(vertex));
    });

    return rslt;
}

function main() {
    processFile('./bfs_in.txt');
    //processInput();
}

function processInput() {
    const ws: WriteStream = createWriteStream(process.env['OUTPUT_PATH']);
    const q: number = parseInt(readLine().trim(), 10);
    for (let qItr: number = 0; qItr < q; qItr++) {
        const firstMultipleInput: string[] = readLine().replace(/\s+$/g, '').split(' ');
        const n: number = parseInt(firstMultipleInput[0], 10);
        const m: number = parseInt(firstMultipleInput[1], 10);
        let edges: number[][] = Array(m);

        for (let i: number = 0; i < m; i++) {
            edges[i] = readLine().replace(/\s+$/g, '').split(' ').map(edgesTemp => parseInt(edgesTemp, 10));
        }

        const s: number = parseInt(readLine().trim(), 10);
        const result: number[] = bfs(n, m, edges, s);
        ws.write(result.join(' ') + '\n');
    }

    ws.end();
}

function processFile(fileName: string) {
    inputLines = [];
    var s = fs.createReadStream(fileName)
        .pipe(es.split())
        .pipe(es.mapSync(function(inputLine: string) {

            // pause the readstream
            s.pause();

            inputLines.push(inputLine);

            // process line here and call s.resume() when rdy
            // function below was for logging memory usage
            // resume the readstream, possibly from a callback
            s.resume();
        })
        .on('error', function(err: string){
            console.log('Error reading file.', err);
        })
        .on('end', function(){
            processInput();
            console.log(`Done.`);
        })
    ); 
}

//function main() {}

//let rslt = bfs(4, 2, [[1,2],[1,3]], 1);
//console.log(`rslt = ${rslt}`);

