DESTDIR ?= dist
LABS ?= $(foreach lab,$(filter-out dist/,$(sort $(dir $(wildcard */)))),$(lab:/=))

PDFS := $(foreach lab,$(LABS),$(DESTDIR)/lr-$(lab).pdf)

### Phony ######################################################################

.PHONY: all dist-% clean clean-all clean-dist clean-build

all: $(PDFS)

clean:
	@rm --verbose --recursive --force $(DESTDIR)

### Build general ##############################################################

$(DESTDIR):
	@mkdir --verbose --parent $(DESTDIR)

### Build reports ##############################################################

define mk-report =

$(DESTDIR)/lr-$(1).pdf: $(DESTDIR)
	@cp --verbose $(1)/report.pdf $(DESTDIR)/lr-$(1).pdf

endef

$(foreach lab,$(LABS),$(eval $(call mk-report,$(lab))))
