MKDS := $(patsubst %.mkd, %.html, $(wildcard *.mkd))

all: $(MKDS)

clean: 
	rm $(MKDS)
rebuild: clean all

%.html : %.mkd
	pandoc -f markdown --section-divs -t html5 -s --template ../lib/template.revealjs -o $@ $^  --variable theme=sky
