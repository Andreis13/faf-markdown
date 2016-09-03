# FAF::Markdown

This is the Course Work for the APPOO class. It is a simple Markdown parser
with very limited and unreliable functionality.

## Installation

* Clone repo
* Build gem
* Install gem from the local build

## Usage

The gem contains 2 executables `faf-markdown` and `faf-markdown-app`. The former
is a CLI application that just reads markdown from `stdin` if no option is given.
It supports two options:
  * `--url URL` - fetches the markdown from the supplied URL
  * `--file FILENAME` - gets the markdown from the specified file

And the later is a sinatra application that displays a form with a text field
where you can specify the URL of a markdown file and it will parse it and display
the result as beautiful HTML as well as the obtained source.


