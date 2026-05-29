# fortunes-biofx -- a bioinformatics fortune cookie pack
#
#   make            compile the .dat index files (needs `strfile`)
#   make install    install fortunes into the system fortune directory
#   make uninstall   remove them again
#   make test       print a random biofx fortune
#   make clean      remove generated .dat files

# Source fortune files (no extension; strfile generates the .dat indexes)
FORTUNES := biofx biofx-quotes biofx-local
DATS     := $(addsuffix .dat,$(FORTUNES))

# Where the `fortune` command looks for cookie files. Override on the
# command line if your distro differs, e.g.:
#   make install FORTUNE_DIR=/usr/local/share/games/fortunes
FORTUNE_DIR ?= $(shell \
	for d in /usr/share/games/fortunes \
	         /usr/local/share/games/fortunes \
	         /usr/share/fortune \
	         /opt/homebrew/share/games/fortunes \
	         /usr/local/Cellar/fortune; do \
		[ -d "$$d" ] && { echo "$$d"; break; }; \
	done)

STRFILE := strfile

.PHONY: all install uninstall test clean check-strfile check-dir

all: $(DATS)

%.dat: %
	$(STRFILE) -c % $< $@

check-strfile:
	@command -v $(STRFILE) >/dev/null 2>&1 || { \
		echo "error: '$(STRFILE)' not found. Install the 'fortune' package:"; \
		echo "  Debian/Ubuntu : sudo apt install fortune-mod"; \
		echo "  macOS (brew)  : brew install fortune"; \
		echo "  Fedora        : sudo dnf install fortune-mod"; \
		exit 1; }

check-dir:
	@[ -n "$(FORTUNE_DIR)" ] || { \
		echo "error: could not locate the system fortune directory."; \
		echo "set it explicitly, e.g. make install FORTUNE_DIR=/usr/share/games/fortunes"; \
		exit 1; }

install: check-strfile check-dir all
	install -d "$(FORTUNE_DIR)"
	@for f in $(FORTUNES); do \
		echo "installing $$f -> $(FORTUNE_DIR)"; \
		install -m 644 $$f     "$(FORTUNE_DIR)/$$f"; \
		install -m 644 $$f.dat "$(FORTUNE_DIR)/$$f.dat"; \
	done
	@echo "done. try:  fortune biofx"

uninstall:
	@for f in $(FORTUNES); do \
		rm -f "$(FORTUNE_DIR)/$$f" "$(FORTUNE_DIR)/$$f.dat"; \
	done
	@echo "removed biofx fortunes from $(FORTUNE_DIR)"

test: check-strfile all
	@fortune -f . 2>/dev/null; echo "---"; fortune .

clean:
	rm -f $(DATS)
