const {createPool} = require('mysql');
const fs = require('fs');

const pool = createPool(
    {
        host:"localhost",
        user:"root",
        password:"",
        database:"db.sql",
        connectionLimit:"20",
        multipleStatements: true
    }
);

const sqlScript = fs.readFileSync('db.sql', 'utf-8');

// Execute the SQL script from db.sql file
pool.query(sqlScript, (err, results) => {
    if (err) {
        console.error('Error executing the SQL script:', err);
    } else {
        console.log('SQL script executed successfully');
    }
});

module.exports = pool;



pool.query('db.sql')
