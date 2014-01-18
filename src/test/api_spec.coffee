should = require 'should'
supertest = require('supertest')
request = supertest('localhost:8080')


describe 'finding text in an image', ->
  picture_path = 'test/testfiles/abbey_road.jpg'
  it 'can recognise text', (done) ->
    request.post('/ocr') .attach('image', picture_path).end (err, res) -> 
      res.text.replace(/(\r\n|\n|\r)/gm," ").replace(RegExp(" +(?= )", "g"), "").should.include("ABBEY ROAD")
      res.should.have.status(200)
      done()

