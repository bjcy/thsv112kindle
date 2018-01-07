# Extracts Bible book name, abbreviation and number of chapters from
# http://m.bibles.org/tha-THSV11/ navigation in order to go to proper pages for
# scraping chapters.
require 'json'
require 'nokogiri'

doc = File.open("books-nav.html") { |f| Nokogiri::XML(f) }
doc.encoding = 'UTF-8'

bible_books = []

lis = doc.css("ul.book > li")
lis.each do |li|
	book_abbr = li['id']
	book_name = li.css("a[data-ajax='false']")[0].text.strip
	num_chapters = li.css("ul.chapter > li > a:not([class='book-intro'])").count
	#puts "#{book_abbr} : #{chapter_name} - (#{num_chapters})"
	bible_books << {:abbr => book_abbr, :name => book_name, :num_chapters => num_chapters}
end

puts bible_books.to_json