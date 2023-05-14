install.packages('pander')

library(officer)
library(pander)

input_file <- "C:\\Users\\ACER\\Downloads\\Azarinth Healer Chapter 1 - 842.docx"
output_file <- "C:\\Users\\ACER\\Downloads\\file.epub"

# read in the docx file using officer
doc <- read_docx(input_file)

# convert the docx contents to a character string using as_display
doc_str <- print(doc)

# specify the pandoc arguments
pandoc_args <- c("-o", output_file)

# convert the docx string to epub using pandoc_convert
epub_str <- pandoc_convert(doc_str, to = "epub", extra_args = pandoc_args)


# write the epub string to a file
cat(epub_str, file = output_file)
