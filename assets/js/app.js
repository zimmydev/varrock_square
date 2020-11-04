/* Import all our CSS */

import "normalize.css";
import "../css/app.scss";

/* Pheonix libraries */

import "phoenix_html";

/* Import the images our app will need */

import background from "./images/background.png";
import contentBackground from "./images/content-background.png";
import banner from "./images/banner.png";
import logo from "./images/logo.png";
import notFound from "./images/not-found.png";

/* Mount and initialize the elm app */

import {Elm} from "../elm/src/Main.elm";

// Find the DOM node that we'll mount onto
const node = document.getElementById("elm-app-mount");

// Allow cached data which propogates to open tabs
const cacheKey = "varrock-square-cache";
const cache = JSON.parse(localStorage.getItem(cacheKey));

// Setup app flags
const dimensions = [window.innerWidth, window.innerHeight];
const images = {background, contentBackground, banner, logo, notFound};
const flags = {cache, dimensions, images};

// console.info("Starting elm app with flags:", flags);

const app = Elm.Main.init({flags, node});

/* Incoming ports */

/*
// Allow elm to cache a user in localStorage
app.ports.storeCache.subscribe((user) => {
  if (user === null) {
    localStorage.removeItem(userKey);
  } else {
    localStorage.setItem(userKey, JSON.stringify(user));
  }
  // Propogate the cache change back to the app, in a nonblocking fashion
  setTimeout(() => app.ports.cacheChanged.send(user), 0);
});
*/

/* Outgoing ports */

/*
// Allow changes to the cache across the browser to propogate to the app
window.addEventListener(
  "storage",
  (event) => {
    if (event.storageArea === "localStorage" && event.key === userKey) {
      app.ports.cacheChanged.send(event.newValue);
    }
  },
  false
);
*/
