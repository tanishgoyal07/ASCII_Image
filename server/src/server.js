const http = require("http");

require("dotenv").config();

const app = require("./app");

const PORT = process.env.PORT || 8000;

const server = http.createServer(app);

server.listen(PORT, () => {
  console.log(`Listening on PORT ${PORT}`);
});

// const API_URL = "http://localhost:8000/v1";