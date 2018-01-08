# Runs pandoc on books directory to create full epub file.

pandoc --epub-metadata=metadata.xml -o test.epub -s --toc --toc-depth=3 test.html