const {createPool} = require('mysql');

const pool = createPool(
    {
        host:"localhost",
        user:"root",
        password:"",
        database:"",
        connectionLimit:"",
    }
)

pool.query('')