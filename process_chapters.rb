# Process raw/*.html chapter files into book files.
require 'htmlbeautifier'
require 'json'
require 'nokogiri'

# books => [{:abbr, :name, :num_chapters}]
books = JSON.parse(File.read("books.json"), {:symbolize_names => true})
book = books[1]
chapter_num = 38

book_doc = nil
book_header_string = "<div id=\"#{book[:abbr]}\"><h1>#{book[:name]}</h1></div>"
book_nav_string = "<div id=\"#{book[:abbr]}_nav\"><p>"
book_string = String.new
chapter_count = 1

Dir.glob('raw/02*.html').sort.each do |filename|
	#puts "Processing #{filename}..."
	doc = File.open(filename) { |f| Nokogiri::XML(f) }
	doc.encoding = 'UTF-8'

	chapter = doc.css('.chapter')
	chapter.search('h5.r').remove # Subheading references
	chapter.search('.notelink').remove # footnotes/references
	first_child = chapter.children.first
	first_child.add_previous_sibling("<h2>#{book[:name]} #{chapter_count}</h2>")

	# This breaks with a segfault:
	# nokogiri-1.8.1/lib/nokogiri/xml/node_set.rb:190: [BUG] Segmentation fault at 0x0000000000000000 ruby
	#if chapter_count == 1
	#	book_doc = chapter
	#else
	#	break if chapter_count == 29
	#	book_doc += chapter
	#end

	# Instead print to stdout and write to file in shell.
	book_string += chapter.to_s
	book_nav_string += "<a href=\"\##{chapter.first['id']}\">#{book[:name]} #{chapter_count}</a>&nbsp;"
	chapter_count += 1
end

book_nav_string += "</p></div>"

puts HtmlBeautifier.beautify(book_header_string + book_nav_string + book_string)