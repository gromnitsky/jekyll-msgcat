# jekyll-msgcat

Multi-lingual interface with Jekyll via .yaml message catalogs.

Tested with Jekyll 1.2.1.

## Installation

Add this line to your application's Gemfile:

    gem 'jekyll-msgcat'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jekyll-msgcat

## Usage

Create ``_plugins/req.rb`` with 1 line:

	require 'jekyll/msgcat'

Add to ``_config.yml``:

	msgcat:
	  locale: ru

Default locale is always 'en'. 'en' locale is implicit, you cannot
select it.

Create ``_msgcat.yaml``:

	uk:
	  'Home': На головну сторiнку

And use in Liquid templates:

	{{ 'Home' | mc }}

If 'Home' key wasn't found anywhere in the message catalog, or you
didn't select any locale, a string 'Home' will be used.

More info [here](http://gromnitsky.blogspot.com/2013/10/multi-lingual-interface-with-jekyll.html).

## License

MIT.
