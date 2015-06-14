Feature: Command Line Tool

  Scenario Outline: It should parse fragments of markdown that are passed to it
    When I run `bundle exec faf-markdown` interactively
    And I type <input>
    And I close the stdin stream
    Then the output should contain <output>

    Examples:
    | input                           | output                                 |
    | "# some heading"                | "<h1>some heading</h1>"                |
    | "## some heading"               | "<h2>some heading</h2>"                |
    | "arst ## some heading"          | "<p>arst ## some heading</p>"          |
    | "arst ##some heading"           | "<p>arst ##some heading</p>"           |
    | "par 1\n\npar 2"                | "<p>par 1</p>\n\n<p>par 2</p>"         |
    | "par 1\n\n\n\n\npar 2"          | "<p>par 1</p>\n\n<p>par 2</p>"         |

  Scenario: Parse markdown from URL
    When I run `bundle exec faf-markdown --url https://gist.githubusercontent.com/minivan/f29e2759c44d13e39b5b/raw/7bc948fc89d467db05d879e61ac09a7f70f75362/input.md`
    Then the stdout should contain:
    """
    <h1>Hello FAF, this is a document</h1>

    <p>So we're trying to do interesting documents</p>

    <p>They are actually quide <strong>hard</strong>
    Not that <em>easy</em></p>

    <p>What happens if we do ##this?</p>

    <p>How about <code><em>this</em></code>?</p>

    <p><strong>it <em>wor<code>k</code>s!</em></strong></p>

    <p>Let me put a bold link: <a href="http://41.media.tumblr.com/49a58542fd70b8ca39b5bd0d9c9c53aa/tumblr_nob40mvTN41tb9nzio1_500.jpg"><strong>stuff</strong></a></p>

    <h2>Okay, part two</h2>

    <p>But there's no part two!</p>

    <h6>So long!</h6>
    """

  Scenario: Parse piped-in data
    Given a file named "input" with:
    """
    ## Hello FAF, this is a document
    What happens if we do [**stuff**](http://41.media.tumblr.com/49a58542fd70b8ca39b5bd0d9c9c53aa/tumblr_nob40mvTN41tb9nzio1_500.jpg)?

    How about `*this*`?

    **it *wor`k`s!***
    """
    When I run `bundle exec faf-markdown` interactively
    And I pipe in the file "input"
    Then the stdout should contain:
    """
    <h2>Hello FAF, this is a document</h2>

    <p>What happens if we do <a href="http://41.media.tumblr.com/49a58542fd70b8ca39b5bd0d9c9c53aa/tumblr_nob40mvTN41tb9nzio1_500.jpg"><strong>stuff</strong></a>?</p>

    <p>How about <code><em>this</em></code>?</p>

    <p><strong>it <em>wor<code>k</code>s!</em></strong></p>
    """

  Scenario: Parse data from a file
    Given a file named "input" with:
    """
    ## Hello FAF, this is a document
    What happens if we do [**stuff**](http://41.media.tumblr.com/49a58542fd70b8ca39b5bd0d9c9c53aa/tumblr_nob40mvTN41tb9nzio1_500.jpg)?

    How about `*this*`?

    **it *wor`k`s!***
    """
    When I run `bundle exec faf-markdown --file input`
    Then the stdout should contain:
    """
    <h2>Hello FAF, this is a document</h2>

    <p>What happens if we do <a href="http://41.media.tumblr.com/49a58542fd70b8ca39b5bd0d9c9c53aa/tumblr_nob40mvTN41tb9nzio1_500.jpg"><strong>stuff</strong></a>?</p>

    <p>How about <code><em>this</em></code>?</p>

    <p><strong>it <em>wor<code>k</code>s!</em></strong></p>
    """
