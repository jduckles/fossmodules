PUBLISH_BUCKET := s3://static.jduck.net/fossmodules/

MKD_FILES := $(shell find . -type f -name '*.mkd')
HTML_FILES := $(patsubst %.mkd, %.html, $(MKD_FILES))
IMAGE_DIRS := $(shell find . -type d -name "images")
PDF_FILES := $(patsubst %.mkd, %.pdf, $(MKD_FILES))
DOCX_FILES := $(patsubst %.mkd, %.docx, $(MKD_FILES))

HTML := $(patsubst %.mkd, %.html, $(wildcard *.mkd))

slides: $(HTML_FILES)

docx: $(DOCX_FILES)

clean: 
	rm $(HTML_FILES)
	rm $(DOCX_FILES)

rebuild: clean all

publish: 
	s3cmd -P put $(HTML_FILES) $(PUBLISH_BUCKET) 
	s3cmd -P --recursive put $(IMAGE_DIRS) $(PUBLISH_BUCKET)

%.docx: %.mkd
	pandoc -f markdown -t docx -o $@ $^


%.html : %.mkd
	pandoc -f markdown --section-divs -t html5 -s --template lib/template.revealjs -o $@ $^  --variable theme=sky

