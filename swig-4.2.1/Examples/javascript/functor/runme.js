var example = require("example");

a = new example.intSum(1);
b = new example.doubleSum(100.0);
c = new example.intSum();

// Use the objects.  They should be callable just like a normal
// javascript function.

for (i=1;i<=100;i++) {
    a.call(i);                // Note: function call
    b.call(Math.sqrt(i));     // Note: function call
    c.call(i);
}

console.log(a.result());
console.log(b.result());
console.log(c.result());

