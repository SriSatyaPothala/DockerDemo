const express = require('express');
const { Pool } = require('pg');

const app = express();
const port = 3000;

const pool = new Pool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME,
});

app.get('/', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM profile LIMIT 1');
    const profile = result.rows[0];
    res.send(`
      <h1>Hello, I'm ${profile.name}</h1>
      <p>Role: ${profile.batch}</p>
      <p>Email: ${profile.email}</p>
    `);
  } catch (err) {
    console.error(err);
    res.status(500).send('Error fetching profile');
  }
});

app.listen(port, () => {
  console.log(`Server is running at http://localhost:${port}`);
});