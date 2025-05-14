const db = require('../models/db')
const express = require('express')
const router = express.Router()

router.get('/', async (req, res) => {
  try {
    const result = await db.query('SELECT * FROM trainings ORDER BY date, time')
    res.status(200).json(result.rows)
  } catch (err) {
    console.error('Ошибка при получении расписания:', err)
    res.status(500).json({ message: 'Ошибка сервера при получении расписания' })
  }
})

router.post('/:id/book', async (req, res) => {
  const trainingId = req.params.id
  const { userEmail } = req.body

  if (!userEmail) {
    return res.status(400).json({ message: 'Email обязателен' })
  }

  try {
    await db.query(
      'INSERT INTO registrations (user_email, training_id) VALUES ($1, $2)',
      [userEmail, trainingId]
    )
    res.status(201).json({ message: 'Вы записались на тренировку!' })
  } catch (err) {
    console.error('Ошибка при записи:', err)
    if (err.code === '23505') {
      return res.status(400).json({ message: 'Вы уже записаны на эту тренировку' })
    }
    res.status(500).json({ message: 'Ошибка при записи на тренировку' })
  }
}) 

router.delete('/:id/unbook', async (req, res) => {
  const trainingId = req.params.id
  const { userEmail } = req.body

  if (!userEmail) {
    return res.status(400).json({ message: 'Email обязателен' })
  }

  try {
    const result = await db.query(
      'DELETE FROM registrations WHERE user_email = $1 AND training_id = $2',
      [userEmail, trainingId]
    )

    if (result.rowCount === 0) {
      return res.status(404).json({ message: 'Запись не найдена' })
    }

    res.status(200).json({ message: 'Запись успешно отменена' })
  } catch (err) {
    console.error('Ошибка при удалении записи:', err)
    res.status(500).json({ message: 'Ошибка сервера при удалении записи' })
  }
})


router.get('/my/:email', async (req, res) => {
  const userEmail = req.params.email

  try {
    const result = await db.query(`
      SELECT r.id, t.title, t.trainer, t.date, t.time
      FROM registrations r
      JOIN trainings t ON r.training_id = t.id
      WHERE r.user_email = $1
      ORDER BY t.date, t.time
    `, [userEmail])

    res.status(200).json(result.rows)
  } catch (err) {
    console.error('Ошибка при получении записей:', err)
    res.status(500).json({ message: 'Ошибка сервера' })
  }
})

router.post('/', async (req, res) => {
  const { title, trainer, date, time, slots } = req.body

  if (!title || !trainer || !date || !time || !slots) {
    return res.status(400).json({ message: 'Все поля обязательны' })
  }

  try {
    await db.query(
      'INSERT INTO trainings (title, trainer, date, time, slots) VALUES ($1, $2, $3, $4, $5)',
      [title, trainer, date, time, slots]
    )
    res.status(201).json({ message: 'Тренировка добавлена' })
  } catch (err) {
    console.error('Ошибка при добавлении тренировки:', err)
    res.status(500).json({ message: 'Ошибка сервера' })
  }
})


module.exports = router