const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')

const app = express()

const authRoutes = require('./routes/auth')
const trainingsRoutes = require('./routes/trainings')

app.use(cors())
app.use(bodyParser.json())
app.use('/api/auth', authRoutes)
app.use('/api/trainings', trainingsRoutes)


const PORT = 8080
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`)
})

const db = require('./models/db')

db.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Ошибка подключения к базе:', err)
  } else {
    console.log('База подключена, текущее время:', res.rows[0])
  }
})
