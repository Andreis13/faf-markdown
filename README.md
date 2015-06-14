# FAF::Markdown

This is the Course Work for the APPOO class. It is a simple Markdown parser
with very limited and unreliable functionality.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'faf-markdown'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install faf-markdown

## Usage

The gem contains 2 executables `faf-markdown` and `faf-markdown-app`. The former
is a CLI application that just reads markdown from `stdin` if no option is given.
It supports two options:
  * `--url URL` - fetches the markdown from the supplied URL
  * `--file FILENAME` - gets the markdown from the specified file


