const express = require("express");
const https = require("https");
const request = require("request");
const bodyParser = require("body-parser")
const date = require(__dirname + "/date.js")


let app = express();
app.set("view engine", "ejs")
app.use(express.static("public"));
app.use(bodyParser.urlencoded({ extended: true }));



let items = ["Wake up early.", "Have a nice breakfast.", "Start coding."];

app.get("/", (req, res) => {

    let day = date.getDate();
    res.render("list", { listTitle: day, newListItem: items })
})



app.post("/", (req, res) => {
    let item = req.body.newItem;
    items.push(item)
    res.redirect("/");

})



const PORT = process.env.PORT || 3000;

app.listen(PORT, console.log(`Server started on ${PORT}`));



