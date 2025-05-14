const db = require('../models/db')
const express = require('express')
const router = express.Router()

router.post('/register', async (req, res) => {
  const { name, email, password } = req.body

  if (!name || !email || !password) {
    return res.status(400).json({ message: 'Все поля обязательны для заполнения' })
  }

  try {
    const userExists = await db.query('SELECT * FROM users WHERE email = $1', [email])

    if (userExists.rows.length > 0) {
      return res.status(400).json({ message: 'Пользователь уже существует' })
    }

    await db.query('INSERT INTO users (name, email, password) VALUES ($1, $2, $3)', [
      name,
      email,
      password
    ])

    res.status(201).json({ message: 'Регистрация успешна' })
  } catch (err) {
    console.error('Ошибка при регистрации:', err)

    if (err.code === '23505') {
      return res.status(400).json({ message: 'Email уже используется' })
    }

    res.status(500).json({ message: 'Ошибка сервера' })
  }

})

router.post('/login', async (req, res) => {
  const { email, password } = req.body

  try {
    const result = await db.query('SELECT * FROM users WHERE email = $1', [email])

    if (result.rows.length === 0) {
      return res.status(400).json({ message: 'Пользователь не найден' })
    }

    const user = result.rows[0]

    if (user.password !== password) {
      return res.status(401).json({ message: 'Неверный пароль' })
    }

    res.status(200).json({ message: 'Вход успешен', user: { id: user.id, name: user.name, email: user.email } })
  } catch (err) {
    console.error('Ошибка при входе:', err)
    res.status(500).json({ message: 'Ошибка сервера' })
  }
})


module.exports = router