.PHONY: all build check clean help tangle

VENV_DIR := .venv
VENV_PYTHON := $(VENV_DIR)/bin/python
VENV_PIP := $(VENV_DIR)/bin/pip
MD_TANGLE := $(VENV_DIR)/bin/md-tangle
# stylua from PATH, else the one mason installs for nvim
STYLUA ?= $(shell command -v stylua || echo $(HOME)/.local/share/nvim/mason/bin/stylua)

# Lua output checked against stylua (each dir uses its nearest .stylua.toml)
STYLUA_PATHS := dist/nvim dist/wezterm

# Default target - clean, build and check
all: clean build check

# Create virtual environment if it doesn't exist
$(VENV_PYTHON):
	@echo "Creating virtual environment..."
	python3 -m venv $(VENV_DIR)

# Install md-tangle if not present
$(MD_TANGLE): $(VENV_PYTHON)
	@echo "Installing md-tangle..."
	$(VENV_PIP) install --quiet "md-tangle>=2.2.0"

# Clean build artifacts
clean:
	rm -rf dist

# One target per tool, taken from the <tool>_ prefix of configurations/*.md.
# Each tangles every configurations/<tool>_*.md in one run.
TOOLS := $(sort $(foreach f,$(notdir $(wildcard configurations/*_*.md)),$(firstword $(subst _, ,$(f)))))

.PHONY: $(TOOLS)

# Build all configuration files
build: $(TOOLS)

$(TOOLS): $(MD_TANGLE)
	$(MD_TANGLE) $(sort $(wildcard configurations/$@_*.md)) -f -d dist/$@/

# Check that tangled Lua matches the stylua rules
check:
	$(STYLUA) --check $(STYLUA_PATHS)

# Show md-tangle help page
help: $(MD_TANGLE)
	$(MD_TANGLE) --help

# Tangle a specific configuration (drop-in for md-tangle; args after --).
# Usage: make tangle -- configurations/nvim_*.md -f -d dist/nvim/
tangle: $(MD_TANGLE)
	$(MD_TANGLE) $(filter-out tangle,$(MAKECMDGOALS))

# Swallow passthrough words so make doesn't treat them as real targets.
%:
	@:
