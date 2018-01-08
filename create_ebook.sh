# Runs pandoc on books directory to create full epub file.
pandoc -s -o test.epub --toc --toc-depth=3 test.html