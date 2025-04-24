const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send(`
    <h1>Hello, I'm Your Sri Satya Pothala</h1>
    <p>BATCH: DO-C-WD-E-15</p>
    <p>Email:satyasreepothala114@gmail.com</p>
  `);
});

app.listen(3000, () => {
  console.log('Server running on http://localhost:3000');
});
