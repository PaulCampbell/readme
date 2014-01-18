var express = require('express'),
    path = require('path'),
    fs = require('fs'),
    ncr = require('nodecr');

var PORT = 49001;

var app = express();
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');

app.get('/', function (req, res) {
  res.send('readme');
});

app.get('/ocr', function (req, res) {
  res.render('ocr');
});

app.post('/ocr', function (req, res) {
  fs.readFile(req.files.displayImage.path, function (err, data) {
    var newPath = __dirname + "/uploads/" + new Date().getTime();
    fs.writeFile(newPath, data, function (err) {
      ncr.process(__dirname + newPath, function(err, text){
        if(err) return console.error(err)

        res.send(text);
      }, 'eng', 6)
    });
  });
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);

