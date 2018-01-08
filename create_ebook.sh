# Runs pandoc on source.html to create full epub file.
pandoc --epub-chapter-level=2 --epub-metadata=metadata.xml -s --toc --toc-depth=1 --write=epub3 -o THSV11.epub source.html