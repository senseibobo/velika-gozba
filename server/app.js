let express = require("express");

let app = express();
let mongo = require("mongodb").MongoClient;

let highscores;
const { MongoClient } = require("mongodb");
const uri =
  "mongodb+srv://igrica:igrica@potraga-za-hranom.k2xn3.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
const client = new MongoClient(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
client.connect((err) => {
  if (err) throw err;
  highscores = client.db("potraga-za-hranom").collection("highscores");
});

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.get("/highscores", (req, res) => {
  highscores.find().toArray((err, result) => {
    if (err) {
      res.sendStatus(404);
      throw err;
    } else res.status(200).send(result);
  });
});

app.post("/highscores/add", (req, res) => {
  if (highscores) {
    let highscore = req.body;
    highscores.find({ name: req.body.name }).toArray((err, result) => {
      if (result.length > 0) {
        let oldscore = result[0];
        if (oldscore.score < req.body.score) {
          highscores.deleteOne({ name: req.body.name });
          highscores.insertOne(highscore);
        }
      } else {
        highscores.insertOne(highscore);
      }
    });
    res.sendStatus(202);
  } else {
    res.sendStatus(500);
  }
});

app.delete("/highscores/", (req, res) => {
  if (req.body.password == "IGRICA!!!!!") {
    highscores.deleteMany({ name: req.body.name });
    res.sendStatus(200);
  } else {
    res.sendStatus(401);
  }
});

module.exports = app;
app.listen(9000);
