# Downloads every chapter from http://m.bibles.org/tha-THSV11/.
require 'addressable/uri'
require 'json'
require 'nokogiri'
require 'open-uri'

root_uri = Addressable::URI.parse("http://m.bibles.org/")

#filename = "pages/#{book_num}-#{book.gsub(/ /,'-')}-#{ch_num}.html" # 01-มัทธิว-1.html
#print "Writing #{filename}..."
#File.write(filename, passage)
#puts " done."

# {:abbr, :name, :num_chapters}
books = JSON.parse(File.read("books.json"), {:symbolize_names => true})
books.each_index do |i|
	book = books[i]
	for ch in 1..book[:num_chapters] do
		print "Processing #{book[:abbr]} #{ch}... "
		chapter_uri = Addressable::URI.parse("/tha-THSV11/#{book[:abbr]}/#{ch}")
		doc = Nokogiri::HTML(open(Addressable::URI.join(root_uri, chapter_uri).normalize))

		# Write to: raw/01-Gen-001.html
		filename = "raw/#{i.to_s.rjust(2, '0')}-#{book[:abbr]}-#{ch.to_s.rjust(3, '0')}.html"
		File.write(filename, doc)
		puts "saved to #{filename}."
		break
	end
	break
end