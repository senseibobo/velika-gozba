let router = require("express").Router();
let db = require("../db.js");

router.get("/", (req, res) => {
  db.highscores.find().toArray((err, result) => {
    if (err) {
      res.sendStatus(404);
      throw err;
    } else res.status(200).send(result);
  });
});

router.post("/", (req, res) => {
  if (highscores) {
    let highscore = req.body;
    db.highscores.find({ name: req.body.name }).toArray((err, result) => {
      if (result.length > 0) {
        let oldscore = result[0];
        if (oldscore.score < req.body.score) {
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

router.delete("/", (req, res) => {
  if (req.body.password == "IGRICA!!!!!") {
    highscores.deleteMany({ name: req.body.name });
    res.sendStatus(200);
  } else {
    res.sendStatus(401);
  }
});

module.exports = router;
