# snow-conditions

Get snow conditions from [Slovenian Environment Agency (ARSO)](http://www.arso.gov.si/vreme/napovedi%20in%20podatki/snegraz.html) via push notification.

Service uses [Nokogiri](http://nokogiri.org/) for parsing HTML, [HTTParty](https://github.com/jnunemaker/httparty) as lib for fetching content. [Clockworks](https://github.com/adamwiggins/clockwork) for doing its magic in loop. Push notifications are dispatched via [Pushover](https://pushover.net) and everything is running on [Heroku](https://www.heroku.com/) with [Redis](http://redis.io).


![snow-conditions via Pusher](https://dl.dropboxusercontent.com/u/697441/snow-conditions.png)

## Setup on Heroku

1. Create new project on [Heroku](https://www.heroku.com/).

2. Add [Redis To Go - Nano](https://addons.heroku.com/redistogo#nano) to [Heroku](https://www.heroku.com/) your instance.

<pre>heroku addons:add redistogo</pre>

3. Create new [Pushover Application](https://pushover.net/apps).

4. Set [Pushover](https://pushover.net/) User and APP keys as environment variables

<pre>heroku config:set PUSHOVER_KEY=app_key_here PUSHOVER_USER=user_key_here</pre>

5. Scale Heroku instance to 1 worker. *One worker is free.*

<pre>heroku ps:scale bot=1</pre>

6. Thats it. You should get Pushover notification in 3,... 2,... 1...

## Testing

1. Create new `.env` inside current folder. Set following values.

<pre>
REDIS_URL=redis://127.0.0.1:6379
PUSHOVER_KEY=pushover_app_key
PUSHOVER_USER=pushover_user_key
</pre>

2. Run `rspec`.

## Contribution

Fork. Share. Have fun.

- [Oto Brglez](https://github.com/otobrglez)
