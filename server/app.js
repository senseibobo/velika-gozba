let express = require("express");

let app = express();
let mongo = require("mongodb").MongoClient;
let highscoresRouter = require("./routers/HighscoresRouter.js")
let accountsRouter = require("./routers/AccountsRouter.js")

app.use(express.json());
app.use(express.urlencoded({ extended: false }));

app.use("/highscores",highscoresRouter);
app.use("/accounts",accountsRouter)


module.exports = app;
app.listen(9000);
