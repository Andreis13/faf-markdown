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



  @final
  Scenario: It parses the markdown provided by course work conditions
    Given a file named "input" with:
    """
    # Hello FAF, this is a document
    So we're trying to do interesting documents

    They are actually quide **hard**
    Not that *easy*

    What happens if we do ##this?

    How about `*this*`?

    **it *wor`k`s!***

    Let me put a bold link: [**stuff**](http://41.media.tumblr.com/49a58542fd70b8ca39b5bd0d9c9c53aa/tumblr_nob40mvTN41tb9nzio1_500.jpg)
    ## Okay, part two

    But there's no part two!

    ###### So long!
    """
    When I run `bundle exec faf-markdown` interactively
    And I pipe in the file "input"
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
