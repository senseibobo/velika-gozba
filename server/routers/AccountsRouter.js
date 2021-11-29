let router = require("express").Router();
const bcrypt = require("bcrypt");

let usernameregex = /^(\d|\w){4,16}/;
let passwordregex = /^(\d|\w){4,16}/;
let db = require("../db.js");

function handleUserLogin(account) {
  let logininfo = {
    username: account.username,
    refreshtoken: 1 /*NE ZNAM*/,
    token: 1 /*NE ZNAM*/,
  };
  db.accounts.updateOne(
    { username: account.username },
    { $set: { token: logininfo.token, refreshtoken: logininfo.token } }
  );
  return logninfo;
}

router.post("/login", (req, res) => {
  ({ username, password } = req.body);
  const account = await db.accounts.findOne({ username: username });
  if (!account) return res.sendStatus(403);
  const [err, salt] = await bcrypt.genSalt(10);
  const [err, hash] = await bcrypt.hash(password, salt);
  if (account.passwordhash == hash) {
    let logininfo = handleUserLogin(account);
    res.status(200).send(logininfo);
  }
});

router.post("/register", (req, res) => {
  ({ email, username, password } = req.body);
  if (db.accounts.find({ $or: [{ email: email }, { username: username }] })) {
    return res.sendStatus(406);
  }
  const [err, salt] = await bcrypt.genSalt(10);
  const [err, hash] = await bcrypt.hash(password, salt);
  let logininfo = handleUserLogin(account);
  res.status(200).send(logininfo);
});
