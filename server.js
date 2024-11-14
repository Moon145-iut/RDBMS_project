// server.js
const express = require('express');
const authRoutes = require('C:\rdbms\medicare\route\auth.js');
const userRoutes = require('C:\rdbms\medicare\route\user.js');

const app = express();

app.use(express.json());


app.use('/auth', authRoutes);
app.use('/users', userRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
