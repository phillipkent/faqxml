faqxml
======

Generate FAQ lists in html, plain text or TeX/PDF from a single source written in XML.

The [DocBook](http://sourceforge.net/projects/docbook/) xml format includes the qandaset element for the creation of FAQ listings. 

On the other hand, this project implements simple xsl stylesheets, which I found useful for my own purposes to create a simple FAQ list (intended for use in a website), where I wanted to see and control all of the details. There are stylesheets for 'folded' html using JavaScript, long html, plain text and TeX. 

The stylesheets also define a glossary document type, which works like the FAQ with a simple change of headings and layout.

CONTENT TO COME.

This project is a modification of "faqxml" by Mikhail Yakshin [http://faqxml.sourceforge.net]. Also uses ideas from the book *XSLT (Second edition)* by Doug Tidwell (O'Reilly, 2008).


XSLT processor
--------------

You need an XSLT processor program to work with faqxml ...............


How to use
----------




Notes
-----

XSLT version 2 is required for the current-date() function.

Cross-referencing: uses the ID datatype; note Tidwell, page 192 on limitations of this.