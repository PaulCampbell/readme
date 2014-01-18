var express = require('express');
var ncr = require('nodecr');
var PORT = 8080;

var app = express();
app.get('/', function (req, res) {
  res.send('Hello World\n');
});


app.get('/ocr', function (req, res) {
  ncr.process(__dirname + '/test/testfiles/abbey_road.jpg',function(err, text){
    if(err) return console.error(err)

    console.log(text)
    res.send(text);
  }, 'eng', 6)
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);

