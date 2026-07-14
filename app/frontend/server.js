const express = require("express");
const axios = require("axios");

const app = express();

app.use(express.urlencoded({ extended: true }));
app.set("view engine", "ejs");

// Change this when deploying on separate EC2/ECS
const BACKEND_URL = process.env.BACKEND_URL || "http://localhost:5000";

app.get("/", async (req, res) => {
    let students = [];

    try {
        const response = await axios.get(`${BACKEND_URL}/students`);
        students = response.data;
    } catch (err) {
        console.log(err.message);
    }

    res.render("index", { students });
});

app.post("/add", async (req, res) => {

    const data = {
        name: req.body.name,
        course: req.body.course
    };

    try {
        await axios.post(`${BACKEND_URL}/students`, data);
    } catch (err) {
        console.log(err.message);
    }

    res.redirect("/");
});

app.listen(3000, "0.0.0.0", () => {
    console.log("Frontend running on port 3000");
});
