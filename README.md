# snow-conditions

Parse snow conditions from [Slovenian Environment Agency (ARSO)](http://www.arso.gov.si/vreme/napovedi%20in%20podatki/snegraz.html) then notify people about them via push notification.

Service uses [Nokogiri](http://nokogiri.org/) for parsing HTML, [HTTParty](https://github.com/jnunemaker/httparty) as lib for fetching content. [Clockworks](https://github.com/adamwiggins/clockwork) for doing its magic in loop. Push notifications are dispatched via [Pushover](https://pushover.net) and everything is running on [Heroku](https://www.heroku.com/) with [Redis](http://redis.io).


![snow-conditions via Pusher](//dl.dropboxusercontent.com/u/697441/snow-conditions.png "little-color on Nexus4")

- [Oto Brglez](https://github.com/otobrglez)
