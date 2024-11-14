// routes/auth.js
const express = require('express');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const connection = require('../db');

const router = express.Router();

// Signup Route
router.post('/signup', async (req, res) => {
    const { username, dob, password, role } = req.body;
    const hashedPassword = await bcrypt.hash(password, 10);

    const query = 'INSERT INTO user_info (username, dob, password, role) VALUES (?, ?, ?, ?)';
    connection.query(query, [username, dob, hashedPassword, role], (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Error signing up' });
        }
        res.status(201).json({ message: 'User registered successfully' });
    });
});

// Login Route
router.post('/login', (req, res) => {
    const { username, password } = req.body;

    const query = 'SELECT * FROM user_info WHERE username = ?';
    connection.query(query, [username], async (err, results) => {
        if (err || results.length === 0) {
            return res.status(404).json({ message: 'User not found, please sign up' });
        }
        const user = results[0];
        const isPasswordMatch = await bcrypt.compare(password, user.password);

        if (!isPasswordMatch) {
            return res.status(401).json({ message: 'Incorrect password' });
        }

        // Generate JWT token
        const token = jwt.sign({ user_id: user.user_id, role: user.role }, 'secret_key', { expiresIn: '1h' });
        res.status(200).json({ message: 'Login successful', token });
    });
});

module.exports = router;
