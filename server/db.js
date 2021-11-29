const { MongoClient } = require("mongodb");
let db;
const uri =
  "mongodb+srv://igrica:igrica@potraga-za-hranom.k2xn3.mongodb.net/myFirstDatabase?retryWrites=true&w=majority";
const client = new MongoClient(uri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});
client.connect((err) => {
  if (err) throw err;
  db.highscores = client.db("potraga-za-hranom").collection("highscores");
  db.accounts = client.db("potraga-za-hranom").collection("accounts");
});
module.exports = db;