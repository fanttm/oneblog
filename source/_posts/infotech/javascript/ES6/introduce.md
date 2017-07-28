
babel-cli工具自带一个babel-node命令，提供一个支持ES6的REPL环境

function f1() {
  let n = 5;
  if (true) {
    let n ;
    console.log('internal: ', n);
  }
  console.log(n); // 5
}

外层代码块不受内层代码块的影响，同样，内层代码块也不不受外层代码块的影响。

块级作用域的出现，实际上使得获得广泛应用的立即执行函数表达式（IIFE）不再必要了。
// IIFE 写法
(function () {
  var tmp = ...;
  ...
}());


如果要将一个已经声明的变量用于解构赋值，必须非常小心。

// 错误的写法
let x;
{x} = {x: 1};
// SyntaxError: syntax error

上面代码的写法会报错，因为JavaScript引擎会将{x}理解成一个代码块，从而发生语法错误。只有不将大括号写在行首，避免JavaScript将其解释为代码块，才能解决这个问题。

// 正确的写法
({x} = {x: 1});

所有模板字符串的空格和换行，都是被保留的，比如<ul>标签前面会有一个换行。如果你不想要这个换行，可以使用trim方法消除它。

$('#list').html(`
<ul>
  <li>first</li>
  <li>second</li>
</ul>
`.trim());

模板字符串中可以运行Javascript表达式，还可以执行函数

模板字符串甚至还能嵌套。

const tmpl = addrs => `
  <table>
  ${addrs.map(addr => `
    <tr><td>${addr.first}</td></tr>
    <tr><td>${addr.last}</td></tr>
  `).join('')}
  </table>
`;

如果需要引用模板字符串本身，在需要时执行，可以像下面这样写。

const data = [
    { first: '<Jane>', last: 'Bond' },
    { first: 'Lars', last: '<Croft>' },
];
console.log(tmpl(data));

// 写法一
let str = 'return ' + '`Hello ${name}!`';
let func = new Function('name', str);
func('Jack') // "Hello Jack!"

// 写法二
let str = '(name) => `Hello ${name}!`';
let func = eval.call(null, str);
func('Jack') // "Hello Jack!"

标签模板的一个重要应用，就是过滤HTML字符串，防止用户输入恶意内容。
标签模板的另一个应用，就是多语言转换（国际化处理）。

ES6对正则表达式添加了u修饰符，含义为“Unicode模式”，用来正确处理大于\uFFFF的Unicode字符。也就是说，会正确处理四个字节的UTF-16编码。

属性的简洁表示法

Object.assign方法实行的是浅拷贝，而不是深拷贝

for...in循环：只遍历对象自身的和继承的可枚举的属性
Object.keys()：返回对象自身的所有可枚举的属性的键名
JSON.stringify()：只串行化对象自身的可枚举的属性

操作中引入继承的属性会让问题复杂化，大多数时候，我们只关心对象自身的属性。所以，尽量不要用for...in循环，而用Object.keys()代替。

对于__proto__属性，标准明确规定，只有浏览器必须部署这个属性，其他运行环境不一定需要部署，而且新的代码最好认为这个属性是不存在的。因此，无论从语义的角度，还是从兼容性的角度，都不要使用这个属性，而是使用下面的Object.setPrototypeOf()（写操作）、Object.getPrototypeOf()（读操作）、Object.create()（生成操作）代替。

Null 传导运算符，const firstName = message?.body?.user?.firstName || 'default';

Null 传导运算符，有四种用法。
    obj?.prop // 读取对象属性
    obj?.[expr] // 同上
    func?.(...args) // 函数或对象方法的调用
    new C?.(...args) // 构造函数的调用

ES6 引入了一种新的原始数据类型Symbol，表示独一无二的值。它是 JavaScript 语言的第七种数据类型，前六种是：undefined、null、布尔值（Boolean）、字符串（String）、数值（Number）、对象（Object）。

Symbol 值通过Symbol函数生成。这就是说，对象的属性名现在可以有两种类型，一种是原来就有的字符串，另一种就是新增的 Symbol 类型。

Symbol函数可以接受一个字符串作为参数，表示对 Symbol 实例的描述，主要是为了在控制台显示，或者转为字符串时，比较容易区分。（实际上不加参数Symbol返回的也是唯一值）

Symbol 值作为对象属性名时，不能用点运算符。

需要注意的是，Symbol.for为Symbol值登记的名字，是全局环境的，可以在不同的 iframe 或 service worker 中取到同一个值。（Symbol值是在运行时生成的，每次运行是否都会生成不同的值？Symbol是否全局唯一？）

只有使用Symbol.for('foo');生成，才能使得该Symbol可以被引用

JavaScript 的对象（Object），本质上是键值对的集合（Hash 结构），但是传统上只能用字符串当作键。这给它的使用带来了很大的限制。
为了解决这个问题，ES6 提供了 Map 数据结构。它类似于对象，也是键值对的集合，但是“键”的范围不限于字符串，各种类型的值（包括对象）都可以当作键。

跟传统的try/catch代码块不同的是，如果没有使用catch方法指定错误处理的回调函数，Promise对象抛出的错误不会传递到外层代码，即不会有任何反应。这个错误不会被捕获，也不会传递到外层代码。正常情况下，运行后不会有任何输出，但是浏览器此时会打印出错误“ReferenceError: x is not defined”，不过不会终止脚本执行，如果这个脚本放在服务器执行，退出码就是0（即表示执行成功）。

一个有趣的问题是，为什么 Node 约定，回调函数的第一个参数，必须是错误对象err（如果没有错误，该参数就是null）？
原因是执行分成两段，第一段执行完以后，任务所在的上下文环境就已经结束了。在这以后抛出的错误，原来的上下文环境已经无法捕捉，只能当作参数，传入第二段。

Promise 的最大问题是代码冗余，原来的任务被 Promise 包装了一下，不管什么操作，一眼看去都是一堆then，原来的语义变得很不清楚。
















