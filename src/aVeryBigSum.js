function aVeryBigSum(arr) {
    if (!arr || arr.size == 0)
        return 0;

    return arr.reduce((prev, next) => prev + next);    
}

function print(arr) {
    if (!arr)
        console.log('null');
    console.log('[' + arr.reduce((prev, next) => prev !== prev + ',' + next) + ']')
}

function test(arr) {
    print(arr);
    console.log(aVeryBigSum(arr));
}

test([10e10,10e10,10e10,10e10,10e10,10e10,10e10,10e10,10e10,10e10]);