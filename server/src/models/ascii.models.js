const google = require("googleapis").google;
const customSearch = google.customsearch("v1");
const imageToAscii = require("image-to-ascii");
const { strip } = require("ansicolor");

const API_KEY = process.env.API_KEY;
const searchEngineId = "10eadc6748b024c38";

async function getImageURL(keyword) {
  async function fetchGoogleAndReturnImagesLinks(query) {
    const response = await customSearch.cse.list({
      auth: API_KEY,
      cx: searchEngineId,
      q: query ,
      searchType: "image",
      num: 2,
    });

    const imagesUrl = response.data.items.map((item) => {
      return item.link;
    });

    return imagesUrl;
  }
  const imagesArray = await fetchGoogleAndReturnImagesLinks(keyword);
  // console.dir(imagesArray, { depth: null });

  return imagesArray[0];
}

// Is a Promise
const getImageFromFile = (url) => {
  return new Promise((resolve, reject) => {
    imageToAscii(url, { colored: false, reverse : true }, (err, converted) => {
      if (err) {
        reject(err);
      } else {
        var res = strip(converted);
        console.log(converted); // ansii
        resolve(res); // text
        console.log(res);
      }
    });
  });
};

async function getImageFromText(keyword) {
  var imageURL = await getImageURL(keyword);
  console.log(imageURL);
  var result = "";
  try {
    result = await getImageFromFile(imageURL);
  } catch (err) {
    console.error(err);
  }
  return result;
}

module.exports = {
  getImageFromText,
  getImageFromFile,
};