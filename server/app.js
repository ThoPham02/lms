var HTTP_PORT = 8000;
var express = require("express");
var app = express();
var db = require("./data.js");
var md5 = require("md5");
var cookieParser = require("cookie-parser");
app.use(cookieParser());
const path = require('path');
var bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(path.join(__dirname, '../public')));

app.listen(HTTP_PORT, () => {
  console.log("Server running on port %PORT%".replace("%PORT%", HTTP_PORT));
});

app.get("/api/announcements", (_, res, next) => {
  var sql = "select * from announcements";
  var params = [];
  db.all(sql, params, (err, rows) => {
    if (err) {
      res.status(400).json({ error: err.message });
      return;
    }
    res.json({
      message: "success",
      data: rows,
    });
  });
});

app.post("/api/register", (req, res, next) => {
  var errors = [];
  let pass = req.body.password;
  if (pass === undefined) {
    errors.push("No password specified");
  }
  if (errors.length) {
    res.status(400).json({ error: errors.join(",") });
    return;
  }
  var data = {
    name: req.body.name,
    password: md5(req.body.password),
  };
  var sql = "INSERT INTO users (name, pass) VALUES (?,?)";
  var params = [data.name, data.password];
  db.run(sql, params, function (err, result) {
    if (err) {
      res.status(400).json({ error: err.message });
      return;
    }
    res.json({
      message: "success",
      data: data,
      id: this.lastID,
    });
  });
});

app.post("/api/login", async (req, res, next) => {
  var errors = [];
  let pass = req.body.password;
  let name = req.body.name;
  if (pass === undefined || name === undefined) {
    errors.push("Name and password must be required");
  }
  if (errors.length) {
    res.status(400).json({ error: errors.join(",") });
    return;
  }
  var sql = "SELECT name FROM users WHERE name = ? AND pass = ?;";
  var params = [name, pass];
  db.all(sql, params, (err, rows) => {
    if (err) {
      res.status(400).json({ error: err.message });
      return;
    }
    if (rows.length === 0) {
      res.send("Incorect Name or Password!");
      return;
    }
    let name = rows[0]["name"];
    res.cookie("name", name, { expires: new Date(Date.now() + 900000) });
    res.send(true);
  });
});

app.get("/api/all/courses", (_, res, next) => {
  var sql = "select * from courses";
  var params = [];
  db.all(sql, params, (err, rows) => {
    if (err) {
      res.status(400).json({ error: err.message });
      return;
    }
    res.json({
      message: "success",
      data: rows,
    });
  });
});

app.get("/api/my/courses", (req, res, next) => {
  if (req.cookies.name) {
    let sql =
      "select * from courses where id in (select course_id from myCourses inner join users on myCourses.user_id = users.id where name = ?);";
    db.all(sql, [req.cookies.name], (err, rows) => {
      if (err) {
        res.status(400).json({ error: err.message });
      }
      res.json({
        messages: "success",
        data: rows,
      });
    });
  } else {
    res.send("please login first!");
  }
});

app.get("/api/course/:courseid/quizes", (req, res, next) => {
  if (req.cookies.name) {
    let courseId = req.params.courseid;
    let sql = "select * from quizes where course_id = ?;";
    db.all(sql, courseId, (err, rows) => {
      if (err) {
        res.status(400).json({ error: err.message });
        return;
      }
      if (rows.length === 0) {
        res.send("Quiz is empty!");
        return;
      }
      res.json({
        message: "success",
        data: rows,
      });
    });
  } else {
    res.send("please login first!");
  }
});

app.get("/api/course/:courseid/doquiz/:quizid", (req, res, next) => {
  if (req.cookies.name) {
    let quizId = req.params.quizid;
    let sql = "select * from questions where quiz_id = ?";
    db.all(sql, quizId, (err, rows) => {
      if (err) {
        res.status(400).json({ error: err.message });
        return;
      }
      res.json({
        message: "success",
        data: rows,
      });
    });
  } else {
    res.send("please login first!");
  }
});

app.post("/api/course/:courseid/doquiz/:quizid", (req, res, next) => {
  if (req.cookies.name) {
    let data = req.body;
    let sql = "SELECT * FROM questions";
    db.all(sql, (err, rows) => {
      if (err) {
        res.status(400).json({ error: err.message });
        return;
      }
      let score = 0;
      for (let i = 0; i < rows.length; i++) {
        for (let j = 0; j < data.length; j++) {
          if (rows[i]["id"] == data[j]["question_id"]) {
            if (rows[i]["answer_id"] == data[j]["answer_id"]) {
              score++;
            }
          }
        }
      }
      res.json({
        message: "success",
        data: score,
      });
    });
  } else {
    res.send("please login first!");
  }
});

app.use(function (req, res) {
  res.status(404);
});
