const express = require("express");

const {
  httpGetImageFromText,
  httpGetImageFromFile,
} = require("./ascii.controller");

const asciiRouter = express.Router();

// routing all "GET v1/ascii/*" req to relevant fxns in controller
asciiRouter.get("/:text", httpGetImageFromText);
asciiRouter.post("/file", httpGetImageFromFile);


module.exports = asciiRouter;