Introduction
============
This is a collection of snippets for YASnippet for use with writing a
JavaScript file using the dojo framework.

Installation
============
I use Steve Yegge's excellent js2-mode so I defined a derived mode named
dojo-js-mode by adding this to my .emacs

      (define-derived-mode dojo-js-mode js2-mode "dojo")

I then created the 'js2-mode' directory in my snippets directory and then
created the subdirectory 'dojo-js-mode' in that directory.  All of these
snippets are placed in the 'dojo-js-mode' directory.  So, my snippet directory
looks like this:

    |-- text-mode
    |   |-- js2-mode
    |   |   |-- dojo-js-mode

Because they are in my snippets directory, they are all loaded when YASnippet
initializes (or M-x yas/reload-all).

Using The Snippets
==================
When I fire up a JavaScript file that will contain dojo, I immediately run
'M-x dojo-js-mode'.  Then all of these snippets are available.

I tried to keep the first two letters for each major function you might use a
lot in dojo.  Thus, 'dc' becomes 'dojo.connect', 'dr' becomes 'dojo.require'.

Contact
=======
Feel free to file an issue at
[Github](http://github.com/slackorama/dojo-yasnippets/issues) if you want to
add anything to this project.  If you fork it, feel free to send me a pull
request.

Resources
=========
[YASnippet](http://pluskid.lifegoo.com/upload/project/yasnippet/doc/index.html)

[js2-mode](http://code.google.com/p/js2-mode/)

[Dojo](http://www.dojotoolkit.org)




