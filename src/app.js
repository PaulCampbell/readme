var express = require('express'),
    path = require('path'),
    fs = require('fs'),
    ncr = require('nodecr');

var PORT = 8080;

var app = express();
app.use(express.bodyParser());
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');

app.get('/', function (req, res) {
  res.send('readme');
});

app.get('/ocr', function (req, res) {
  res.render('ocr');
});

app.post('/ocr', function (req, res) {
  fs.readFile(req.files.image.path, function (err, data) {
    var newPath = __dirname + "/uploads/" + new Date().getTime();
    fs.writeFile(newPath, data, function (err) {
      ncr.process(newPath, function(err, text){
        if(err) return console.error(err)
        console.log("** FOUND: " + text + " **");
        res.send(text);
      }, 'eng', 6)
    });
  });
});

app.listen(PORT);
console.log('Running on http://localhost:' + PORT);

