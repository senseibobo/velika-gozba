let router = require("express").Router()
const bcrypt = require("bcrypt")

let usernameregex = /^(\d|\w){4,16}/
let passwordregex = /^(\d|\w){4,16}/
let db = require("../db.js")


router.post("/login", (req,res) => {
    ({username, password} = req.body);
});

router.post("/register",(req,res) => {
    ({email, username, password} = req.body);
    if (db.accounts.find({$or : [{  }]}) { /*ASDASD */}
    bcrypt.genSalt(10, (err,result) => {
        bcrypt.hash(password, salt, (err,hash) => {
            db.accounts.insertOne({email:email,username:username,passwordhash:hash});
        })
    })
});