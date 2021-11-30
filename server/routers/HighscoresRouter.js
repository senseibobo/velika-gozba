let router = require("express").Router();
let db = require("../db.js");

router.get("/", (req, res) => {
  db.highscores
    .find()
    .sort({ score: -1 })
    .toArray((err, result) => {
      if (err) {
        res.sendStatus(404);
        throw err;
      } else res.status(200).send(result);
    });
});

router.get("/:level", (req, res) => {
  db.highscores
    .find({ level: Number(req.params.level) })
    .limit(5)
    .sort({ score: -1 })
    .toArray((err, result) => {
      if (err) {
        res.sendStatus(404);
        throw err;
      } else res.status(200).send(result);
    });
});

router.post("/", (req, res) => {
  if (db.highscores) {
    let highscore = req.body;
    db.highscores
      .find({
        name: req.body.name,
        level: req.body.level,
      })
      .toArray((err, result) => {
        if (result && result[0]) {
          if (result[0].score < req.body.score) {
            db.highscores.deleteOne({ name: req.body.name });
            db.highscores.insertOne(highscore);
          }
        } else {
          db.highscores.insertOne(highscore);
        }
      });
    res.sendStatus(202);
  } else {
    res.sendStatus(500);
  }
});

router.delete("/:level/:name", (req, res) => {
  if (req.body.password == "IGRICA!!!!!") {
    if (req.params.level === "any") {
      db.highscores.deleteMany({
        name: req.params.name,
      });
    } else {
      db.highscores.deleteMany({
        name: req.params.name,
        level: Number(req.params.level),
      });
    }
    res.sendStatus(200);
  } else {
    res.sendStatus(401);
  }
});

module.exports = router;
