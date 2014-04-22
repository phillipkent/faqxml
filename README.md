faqxml
======

Generate _FAQ_ lists and _glossaries_ in html, plain text or TeX (convertible to PDF) from a single source written in XML.

The [DocBook](http://docbook.sourceforge.net/) XML scheme includes the 'qandaset' element for the creation of FAQ listings and also a 'glossary' element. On the other hand, this project implements simple XSL stylesheets, which I found useful for my own purposes to create a simple FAQ list and a glossary, intended for use in a website, where I wanted to see and control all of the details. There are stylesheets for 'folded' html (using JavaScript), long html, plain text and TeX. 

This project is a modification of "faqxml" by Mikhail Yakshin [http://faqxml.sourceforge.net]. Also it uses ideas from the book *XSLT (Second edition)* by Doug Tidwell (O'Reilly, 2008).

CURRENT STATUS: the XSL files for html are available; others are in development.


XSLT processor
--------------

You need an XSLT processor program to work with faqxml (and it needs to implement xslt version 2: so xsltproc will not work). There are numerous commercial versions. The preferred free program is [Saxon](http://saxon.sourceforge.net/).


How to use
----------

[TO COME]



Notes
-----

XSLT version 2 is required.

Cross-referencing: uses the ID datatype; note Tidwell, page 192 on limitations of this.