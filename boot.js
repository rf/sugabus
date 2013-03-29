var coffee = require("coffee-script");
var fs = require('fs');
coffee.run(fs.readFileSync('./app.coffee', 'utf8'));
