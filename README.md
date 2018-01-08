# thsv112kindle
Grab THSV11 text for personal use on a Kindle/iBooks.

## Usage

```
bundle install
ruby extract_books_data.rb > books.json
ruby download_chapters.rb
ruby process_chapters.rb
ruby make_html.rb all
./create_ebook.sh || ./create_pdf.sh
```

## Requirements

+ ruby
+ bundler (`gem install bundler`)
+ pandoc (`brew install pandoc`)

## Dev Notes

+ http://m.bibles.org/tha-THSV11/Gen/1
+ http://m.bibles.org/tha-THSV11/[BookAbbr]/[Ch]