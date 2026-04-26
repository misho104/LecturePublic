TYPST = typst
TYPSTFLAGS = --font-path=/users/misho/Library/Fonts --input "time=$(shell date '+%H:%M:%S')"

TARGETS = lecture
MAIN = lecture

all: $(TARGETS)

$(TARGETS):
	$(TYPST) compile $(TYPSTFLAGS) $@.typ

watch:
	$(TYPST) watch $(TYPSTFLAGS) $(MAIN).typ

o:
	open $(MAIN).pdf


clean:
	rm -rf $(addsuffix .pdf,$(TARGETS))
