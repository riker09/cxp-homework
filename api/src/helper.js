"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.generateSuffix = exports.rnd = exports.foo = void 0;
const foo = (val) => {
    // f(x) = 26 - x
    return 26 - Math.abs(val);
};
exports.foo = foo;
const suffixes = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
const rnd = (len = 1) => {
    let r = Math.random()
        .toString()
        .substring(2, 2 + len);
    while (r.substring(0, 1) === "0") {
        r = Math.random()
            .toString()
            .substring(2, 2 + len);
    }
    return Number.parseInt(r);
};
exports.rnd = rnd;
const generateSuffix = () => {
    const steps = suffixes.length - 1;
    let r;
    let p = 0.5;
    let i = 0;
    let x = false;
    do {
        r = Math.random();
        x = r < p + (i * (1 - p)) / steps;
        i++;
    } while (!x);
    return suffixes.substring(i, i + 1);
};
exports.generateSuffix = generateSuffix;
