faqxml
======

Generate _FAQ_ lists and _glossaries_ in HTML from a single source written in XML.

The [DocBook](http://docbook.sourceforge.net/) XML scheme is good and includes the 'qandaset' element for the creation of FAQ listings and also a 'glossary' element. On the other hand, this project implements simple XSL stylesheets, which I have found useful for my own purposes to create a simple FAQ list and a glossary, intended for use in a website, where I wanted to see and control all of the details. There are stylesheets for 'folded' html (using JavaScript) and long html. 

Here is a webpage created using the glossary stylesheet: [VDC 2.0 Glossary](http://cloudstore.interoute.com/main/knowledge-centre/library/vdc-20-glossary). Note that the styles of these pages are set externally by the CSS stylesheets of the Drupal website.

This project is a modification of "faqxml" by Mikhail Yakshin [http://faqxml.sourceforge.net]. It uses ideas from the book *XSLT (Second edition)* by Doug Tidwell (O'Reilly, 2008). And thanks to [StackOverflow](http://www.stackoverflow.com) for help with various aspects of XSLT templates.

CURRENT STATUS
--------------

The XSL files for html are available; other formats (plain text and TeX) are in development.


XSLT processor
--------------

You need an XSLT processor program to work with faqxml, and it needs to implement xslt version 2 so [xsltproc](http://xmlsoft.org/XSLT/xsltproc.html) will not work. 

There are numerous commercial processors. 

The preferred free program is [Saxon](http://saxon.sourceforge.net/). This runs on Java and can be used on any operating system with a 'Java runtime environment' installed.


How to use: FAQ
---------------

[TO COME]


How to use: Glossary
--------------------

### Getting started

Create an XML file containing a single `<glossary>` element, and put inside this a `<glossentry>` element for each entry of
the glossary.

Run your XSLT processor using `glossary-html.xsl` as the stylesheet.

The stylesheet includes a section for CSS styles (it is commented out). Use these to add local styles to your HTML file. 

### Attributes to `<glossary>`

#### Required

`title="The Glossary Heading"` (this will be displayed as the heading of the HTML page/document)

#### Optional

`version="1.0.1a beta"` (any numbers or text for version information; displayed as subtitle)

`date="2014-05-24"` (any numbers or text for date information, displayed as subtitle; if no date specified, the current date is displayed in ISO format)

Use `sorted="true"` to get output with entries sorted based on alphabetical order of `sortkey`, otherwise the order is as given in the xml source

Use `alphahead="true"` to get alphabetical letter headings (only when `sortkey="true"`)
 
Use `toplinks="true"` to get "Back to Top" links (only when `alphahead="true"`)

(Not yet implemented: grouping/sorting based on `topickey`)

### The contents of a `<glossentry>`
Here is an example:

    <glossentry glen-id="corinthian-column" sortkey="column" topickey="Ancient styles"> 
    <status>published</status> 
    <comment>Brief description to start; this needs to be expanded</comment>
    <glossterm>Corinthian column</glossterm> 
    <glossdef> 
    Corinthian columns are slender and fluted. Their capitals are bell-shaped decorated with acanthus leaves.</glossdef> 
    </glossentry>

Explanation:

`glen-id` is the unique ID string you use to make links to this entry (in HTML it becomes the content of `<a name="..."\>`)

`sortkey` is the text which will be used for alphabetical sorting; it's useful because in a multi-word term the first word may not be the one that you want to decide the sort order

`topickey` is a text string that specifies the topic of the entry; not currently used - a later version of faqxml will implement grouping and sorting of entries using this key

`status` is published or unpublished; if unpublished the entry is not included in the output

`comment` is a private comment, it is not included in the output

`glossterm` is the glossary term

`glossdef` is the definition of the term; note the linebreak after `<glossdef>` and there is NOT a linebreak before `<\glossdef>`; you need to do it this way so the linebreaks in the output come out correctly.

### Cross-referencing within the glossary 
Use `<glenref refid="[the glossterm tag]" linktext="the link text">` (creates a link with "the link text") or `<glenref refid=""[the glossterm tag]"">` (creates a link with the full glossterm).

Example files
-------------

example-faq.xml [TO COME]

example-glossary.xml


Notes
-----

The glossary format is modelled on the example in the *Chicago Manual of Style (16th edition)* [http://www.chicagomanualofstyle.org]. To modify this you will mainly want to look at the template `match="glossentry"` in glossary-html.xsl .

Cross-referencing uses the ID datatype; see D. Tidwell *XSLT*, page 192, on the limitations of this.