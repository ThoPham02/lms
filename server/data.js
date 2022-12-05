var sqlite3 = require('sqlite3').verbose();
var md5 = require('md5');

const db = 'lms.db'

let data = new sqlite3.Database(db, (err) => {
    if (err) {
        console.log(err.message);
    }
})

module.exports = data;