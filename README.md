# Ddate

The old unix systems used to come with a ddate command that gave the
Discordian Date, usually something like

    Sweetmorn, Bureaucracy 42, 3161 YOLD

This is a reimplementation in ruby, FNAR.

## Installation

Add this line to your application's Gemfile:

    gem 'ddate'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ddate

## Usage

Try:

    $ ddate -h

Otherwise the command line is basically the same as the old ddate(1) program:

    $ ddate [ -h | -f | -v ] [+format] [day month year]

Use `-f` to see the formatting options.

## Contributing

1. Fork it ( https://github.com/tamouse/ddate/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## References

* [Discordian Calendar](https://en.wikipedia.org/wiki/Discordian_calendar) at wikipedia.
* [Principia Discordia Calendar Converter](http://principiadiscordia.com/book/41.php)
* [C implementation of ddate(1)](https://github.com/bo0ts/ddate)

