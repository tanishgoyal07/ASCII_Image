/* Routing for the v1 API */
const express = require("express");

const asciiRouter = require("./ascii/ascii.router");

const api = express.Router();

api.use("/ascii", asciiRouter);

module.exports = api;