# thsv112kindle
Grab THSV11 text for personal use on a Kindle.

## Usage

```
bundle install
```

## Dev Notes

http://m.bibles.org/tha-THSV11/Gen/1
http://m.bibles.org/tha-THSV11/[BookAbbr]/[Ch]

```html
div#passage
  div#container
  	div#main
  	  div.passagedisplay
  	  	div#[BookAbbr].[Ch3]
  	  		h3.s SectionTitle
  	  			LOOP: p.verse-block (a block of verses)
  	  				span.v[Book#0]_[Ch#]_[V#] (This can be split over multiple p.verse-block's, like in the Psalms. Need to be combined.)
  	  					sup#[BookAbbr].[Ch#].[V#] Verse #
  	  					VerseText
  	  					a.notelink (This can be deleted.)
```