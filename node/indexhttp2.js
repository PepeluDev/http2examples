const express = require('express')
const fs = require('fs')
const spdy = require('spdy')
const port = 3000

const app = express()

app.get('/', (req, res) => {
  console.log("Request received!")
  res.send('Hello from HTTP/2!\n')
})

const options = {
  key: fs.readFileSync('/usr/local/share/ca-certificates/myhttp2server.key'),
  cert:  fs.readFileSync('/usr/local/share/ca-certificates/myhttp2server.crt')
};

spdy.createServer(options, app)
    .listen(port, (error) => {
      if (error) {
        console.error(error)
        return process.exit(1)
      } else {
        console.log(`HTTP/2 app listening in ${port}`)
      }
  })
