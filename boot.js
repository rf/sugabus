var coffee = require("coffee-script");
var fs = require('fs');
console.log('booting');
coffee.run(fs.readFileSync('./app.coffee', 'utf8'));
