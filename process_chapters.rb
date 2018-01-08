# Process raw/*.html chapter files into book files.
require 'htmlbeautifier'
require 'json'
require 'nokogiri'

# books => [{:abbr, :name, :num_chapters}]
books = JSON.parse(File.read("books.json"), {:symbolize_names => true})
books.each_index do |i|
	book = books[i]
	book_num = i+1

	book_doc = nil
	book_header_string = "<h1 id=\"#{book[:abbr]}\">#{book[:name]}</h1>"
	book_nav_string = "<div id=\"#{book[:abbr]}_nav\"><p>"
	book_string = String.new
	chapter_count = 1
	Dir.glob("raw/#{book_num.to_s.rjust(2, '0')}*.html").sort.each do |filename|
		puts "Processing #{filename}..."
		doc = File.open(filename) { |f| Nokogiri::XML(f) }
		doc.encoding = 'UTF-8'

		chapter = doc.css('.chapter')
		chapter.search('h5.r').remove # Subheading references
		chapter.search('.notelink').remove # footnotes/references

		# Create header.
		chapter_id = chapter.first['id']
		chapter.first.remove_attribute('id')
		chapter_header = Nokogiri::XML::Node.new("h2", doc)
		chapter_header['id'] = chapter_id
		chapter_header.content = "#{book[:name]} #{chapter_count}"
		chapter.push(chapter_header)

		book_string += chapter.reverse.to_s
		book_nav_string_link = "#{book[:name]} #{chapter_count}"
		book_nav_string += " <a href=\"\##{chapter_id}\" class=\"nobr\">#{book_nav_string_link.gsub(" ","&nbsp;")}</a>&nbsp;&nbsp;&nbsp;"
		chapter_count += 1
	end

	book_nav_string += "</p></div>"
	filename = "books/#{book_num.to_s.rjust(2, '0')}-#{book[:abbr]}.html"
	File.write(filename, HtmlBeautifier.beautify(book_header_string + book_nav_string + book_string))
end