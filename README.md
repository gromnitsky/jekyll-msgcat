# jekyll-msgcat

Multi-lingual interface with Jekyll via .yaml message catalogs.

Updated for Jekyll 2.5.3.

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

``_msgcat.yaml`` file **must** be in a directory where the site source
is (e.g. in the save directory you provide in ``jekyll -s foo/bar``).

And use in Liquid templates:

	{{ 'Home' | mc }}

If 'Home' key wasn't found anywhere in the message catalog, or you
didn't select any locale, a string 'Home' will be used.

More info (for version 0.0.2)
[here](http://gromnitsky.blogspot.com/2013/10/multi-lingual-interface-with-jekyll.html).

## News

* 1.0.0

	- The 2nd parameter for `cur_page_in_another_locale` filter in not a
	  class name, but an anchor name. The optional class name is a 3rd
	  parameter now.

	- ``_msgcat.yaml`` file must be in a site source directory (see Usage
	  section).

## License

MIT.
