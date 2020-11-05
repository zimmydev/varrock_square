# Devlog

## 2020 Nov 25

![A basic elm app](https://snipboard.io/JPvaGz.jpg)

- I got a basic elm app running with normalize.css, some custom fonts and reasonable basic style defaults.
  - Some of those style defaults included adjusting the size of the header elements and making them `rem`-based, instead of `em`-based. I think this is much more reasonable and leads to less surprises. As for the size adjustment, I feel `h1` and `h2` and much too large by default, so those have been scaled down. For the most part, the other `h*` elements match the size of their `user agent stylesheet` `em` counterparts.
  - I've decided I prefer to handle font-related styles in a top-level CSS file. I plan on handling basically all other styles with `elm-ui` from within the app.
- Webpack has a tricky learning curve.
- I should figure out a way to isolate the `ElmController` to routes which don't attempt to point to a specific static resource (_e.g._ `/favicon.ico` routes to the elm app if there is no `/favicon.ico` being served; it's of `Content-Type: text/html` so this causes browsers to complain). Maybe we can `404` to any unserviceable request that attempts to access a URL that looks like a file (_i.e._ perhaps routes that look like like `\w+\.\w+$`) and not a page of our app.
