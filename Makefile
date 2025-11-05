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
	$(VENV_PIP) install --quiet md-tangle

# Clean build artifacts
clean:
	rm -rf dist

# Build all configuration files
build: $(MD_TANGLE)
	$(MD_TANGLE) configurations/bash.md -i java -f -d dist/bash/
	$(MD_TANGLE) configurations/bat.md -f -d dist/bat/
	$(MD_TANGLE) configurations/bin.md -f -d dist/bin/
	$(MD_TANGLE) configurations/claude.md -f -d dist/claude/
	$(MD_TANGLE) configurations/conkeror.md -f -d dist/conkeror/
	$(MD_TANGLE) configurations/conky.md -f -d dist/conky/
	$(MD_TANGLE) configurations/emacs.md -f -d dist/emacs/
	$(MD_TANGLE) configurations/git.md -f -d dist/git/
	$(MD_TANGLE) configurations/i3.md -f -d dist/i3/
	$(MD_TANGLE) configurations/ideavimrc.md -f -d dist/ideavim/
	$(MD_TANGLE) configurations/nano.md -f -d dist/nano/
	$(MD_TANGLE) configurations/nvim.md -i plugins -f -d dist/nvim/nvim/
	$(MD_TANGLE) configurations/nvim.md -f -d dist/nvim/nvim-lite/
	$(MD_TANGLE) configurations/rofi.md -f -d dist/rofi/
	$(MD_TANGLE) configurations/sway.md -f -d dist/sway/
	$(MD_TANGLE) configurations/tmux.md -f -d dist/tmux/
	$(MD_TANGLE) configurations/waybar.md -f -d dist/waybar/
	$(MD_TANGLE) configurations/wezterm.md -f -d dist/wezterm/
	$(MD_TANGLE) configurations/xmodmap.md -f -d dist/xmodmap/
	$(MD_TANGLE) configurations/yazi.md -f -d dist/yazi/

# Check that tangled Lua matches the stylua rules
check:
	$(STYLUA) --check $(STYLUA_PATHS)

# Show md-tangle help page
help: $(MD_TANGLE)
	$(MD_TANGLE) --help

# Tangle a specific configuration (drop-in for md-tangle; args after --).
# Usage: make tangle -- configurations/nvim.md -i plugins -f -d dist/nvim/
tangle: $(MD_TANGLE)
	$(MD_TANGLE) $(filter-out tangle,$(MAKECMDGOALS))

# Swallow passthrough words so make doesn't treat them as real targets.
%:
	@:
