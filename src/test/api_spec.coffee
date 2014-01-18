should = require 'should'
request = require 'request'


describe 'finding text', ->
  it 'returns 201 with the link', (done) ->
    request("http://localhost:8080").post("/ocr").attach("file", "testfiles/abbey_road.jpg").end (err, res) ->
      res.should.have.status 200 # 'success' status
      done()

