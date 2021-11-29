let express = require("express");

let app = express();
let mongo = require("mongodb").MongoClient;
let highscoresRouter = require("./routers/HighscoresRouter.js");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use("/highscores", highscoresRouter);

module.exports = app;
app.listen(9000);
