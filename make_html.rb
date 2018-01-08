# Dirty html5 page creator for processed books.
require 'htmlbeautifier'

html_string = '<!doctype html>
<html class="no-js" lang="">
<head>
  <meta charset="utf-8">
  <title>พระคัมภีร์ฉบับมาตรฐาน 2011 (THSV11)</title>
</head>
<body>'
html_end_string = '</body></html>'

filename = ARGV[0].to_s
if File.file?(filename)

	book = File.read(filename)
	html_string += book
	html_string += html_string_end

	puts HtmlBeautifier.beautify(html_string)
elsif filename == "all"
	output_file = File.open('source.html', 'w')
	output_file.puts(html_string)
	Dir.glob("books/*.html").sort.each do |filename|
		puts "Processing #{filename}..."
		book = File.open(filename,'r').each do |line|
			output_file.puts(line)
		end
	end
	output_file.puts(html_end_string)
	output_file.close
else
	puts "File doesn't exist."
end