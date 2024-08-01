# Define variables
PYTHON = python3
PIP = pip3
VENV_DIR = venv
SRC_DIR = src
ARTIFACT = dictionary_tool.zip
REQUIREMENTS = requirements.txt

# Default target
all: build test package

# Create virtual environment and install dependencies
$(VENV_DIR)/bin/activate: $(REQUIREMENTS)
	$(PYTHON) -m venv $(VENV_DIR)
	$(VENV_DIR)/bin/$(PIP) install -r $(REQUIREMENTS)

# Install dependencies
install: $(VENV_DIR)/bin/activate

# Build target (compiling / verifying environment)
build: install
	@echo "Searching for Python files in $(SRC_DIR)..."
	@if [ -n "$(shell find $(SRC_DIR) -name '*.py')" ]; then \
		find $(SRC_DIR) -name '*.py' -print0 | xargs -0 $(VENV_DIR)/bin/$(PYTHON) -m py_compile; \
	else \
		echo "No Python files found in $(SRC_DIR)"; \
		exit 1; \
	fi

# Run tests
test: install
	@echo "Running tests in $(SRC_DIR)/tests..."
	@if [ -n "$(shell find $(SRC_DIR)/tests -name '*.py')" ]; then \
		$(VENV_DIR)/bin/$(PYTHON) -m unittest discover -s $(SRC_DIR)/tests > test_output.log; \
		if grep -q 'Ran 0 tests' test_output.log; then \
			echo "No tests were run"; \
			exit 0; \
		else \
			cat test_output.log; \
		fi; \
	else \
		echo "No test files found in $(SRC_DIR)/tests"; \
	fi

# Create runtime artifact
package: clean
	zip -r $(ARTIFACT) $(SRC_DIR) $(REQUIREMENTS)

# Clean up
clean:
	rm -rf $(VENV_DIR)
	rm -f $(ARTIFACT)
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete

.PHONY: all install build test package clean

