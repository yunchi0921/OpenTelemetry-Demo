require('./meter');
const { metrics } = require('@opentelemetry/api');

const meter = metrics.getMeter('express-server');
let counter = meter.createCounter(
  'http.server.request_per_name.counter',
  {
    description: 'The number of requests per name the server got',
  }
);

const express = require('express');
const app = express();
app.get('/user/:name', (req, res) => {
  counter.add(1, {
    'route': '/user/:name',
    'name' : req.params.name
  });
  res.send("Hello " + req.params.name);
});

app.listen(8081, () => {
  console.log('Server is up and running');
});