MKD_FILES := $(shell find . -type f -name '*.mkd')
HTML_FILES := $(patsubst %.mkd, %.html, $(MKD_FILES))

HTML := $(patsubst %.mkd, %.html, $(wildcard *.mkd))

all: $(HTML_FILES)

clean: 
	rm $(HTML_FILES)

rebuild: clean all

publish: 
	s3cmd -P put $(HTML_FILES) s3://static.jduck.net/fossmodules/ 
	s3cmd -P --recursive put images/ s3://static.jduck.net/fossmodules/images/

%.html : %.mkd
	pandoc -f markdown --section-divs -t html5 -s --template lib/template.revealjs -o $@ $^  --variable theme=sky
