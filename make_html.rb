# Dirty html5 page creator for processed books.
require 'htmlbeautifier'

filename = ARGV[0].to_s
if File.file?(filename)
	html_string = '<!doctype html>
	<html class="no-js" lang="">
	<head>
	  <meta charset="utf-8">
	  <title>พระคัมภีร์ฉบับมาตรฐาน 2011 (THSV11)</title>
	</head>
	<body>'

	book = File.read(filename)
	html_string += book
	html_string += '</body></html>'

	puts HtmlBeautifier.beautify(html_string)
else
	puts "File doesn't exist."
end