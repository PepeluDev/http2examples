const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  console.log("Request received!")
  res.send('Hello from HTTP/1.1!\n')
})

app.listen(port, () => {
  console.log(`HTTP/1.1 app listening in ${port}`)
})
