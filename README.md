We're going to build a [custom Slash command][1], `/faemino`. The official ones need HTTPS and some validation, too much work.

We use the [YouTube API][2] to search for the first result.

####Development

Start the server:

    $ thin start

And go to http://localhost:3000

####Deploying to production

It's running in Heroku:

    $ git push heroku master

A Google API key is needed:

    $ heroku config:set GOOGLE_API_KEY=REPLACE_ME

####TODO

* Allow linking to a particulart point in time (12:34)
* Search in subtitles and point to the right point in time

[1]: https://api.slack.com/slash-commands
[2]: https://developers.google.com/youtube/v3/docs/search/list#examples