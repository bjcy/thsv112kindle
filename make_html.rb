require 'htmlbeautifier'

html_string = '<!doctype html>
<html class="no-js" lang="">
<head>
<meta charset="utf-8">
</head>
<body>'

filename = 'books/56-Titus.html'
book = File.read(filename)

html_string += book
html_string += '</body></html>'

puts HtmlBeautifier.beautify(html_string)
