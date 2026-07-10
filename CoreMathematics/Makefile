# cspell: disable
TYPST = typst
TYPSTFLAGS = --input "time=$(shell date '+%H:%M:%S')" --ignore-system-fonts --font-path=./fonts

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
