const http = require('http');
const port = process.env.PORT || 3888;

const server = http.createServer((req, res) => {
  res.statusCode = 200;
  const message  = 'Hello World.\n';
  res.end(message);
});

// start server process 
server.listen(port, () => {
  console.log(`Server running on http://localhost:${port}/`);
});

