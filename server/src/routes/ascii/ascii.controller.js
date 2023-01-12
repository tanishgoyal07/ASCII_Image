// Logic of the app in models directory
const { getImageFromText, getImageFromFile } = require("../../models/ascii.models");

async function httpGetImageFromText(req, res) {
    const keyword = req.params.text;
    console.log(keyword + " animated")
    const image = await getImageFromText(keyword)

    return res.status(200).json({ansi: image});
}

// POST Request
async function httpGetImageFromFile(req, res) {
    const url = req.body.url
    const image = await getImageFromFile(url)

    return res.status(200).json({ansi: image});
}

module.exports = {
    httpGetImageFromText,
    httpGetImageFromFile,
};