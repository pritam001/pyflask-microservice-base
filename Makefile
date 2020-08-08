CONDA_ENV_NAME=pyflask-base
APP_NAME=pyflask-service
APP_DIR=src
TEST_DIR=test
HOME_DIR_PY_FILES=*.py

# echo _FormatCode_ guide:
# 	0 	Reset all styles
# 	1	Bold
#	32 	Green
#	34 	Blue
#	35 	Magenta
#	36	Cyan
RESET_STYLES=\033[0m
BOLD_BLUE=\033[1m\033[34m
BOLD_CYAN=\033[1m\033[36m

# Signifies our desired python version
# Makefile macros (or variables) are defined a little bit differently than traditional bash, keep in mind that in the Makefile there's top-level Makefile-only syntax, and everything else is bash script syntax.
PYTHON = python3

# .PHONY defines parts of the makefile that are not dependant on any specific file
# This is most often used to store functions
.PHONY = help setup lint test debug clean

# Defining an array variable
FILES = input output

# Defines the default target that `make` will to try to make, or in the case of a phony target, execute the specified commands
# This target is executed whenever we just type `make`
.DEFAULT_GOAL = help

# The @ makes sure that the command itself isn't echoed in the terminal
help:
	@echo "$(BOLD_BLUE)-----------------------------MAKE GUIDE----------------------------$(RESET_STYLES)"
	@echo "$(BOLD_CYAN)make setup$(RESET_STYLES) : Setup pyflask-service"
	@echo "$(BOLD_CYAN)make lint$(RESET_STYLES) : Lint pyflask-service"
	@echo "$(BOLD_CYAN)make test$(RESET_STYLES) : Test pyflask-service"
	@echo "$(BOLD_CYAN)make debug$(RESET_STYLES) : Debug pyflask-service"
	@echo "$(BOLD_CYAN)make clean$(RESET_STYLES) : Clean pyflask-service"
	@echo "$(BOLD_CYAN)make dev-run$(RESET_STYLES) : Run pyflask-service in environment=development"
	@echo "$(BOLD_CYAN)make prod-run$(RESET_STYLES) : Run pyflask-service in environment=prod"
	@echo "$(BOLD_BLUE)-------------------------------------------------------------------$(RESET_STYLES)"


lint: #: Run static analysis with black, flake8, pylint, bandit and mypy
	@echo "$(BOLD_CYAN)Blackifying $(RESET_STYLES)🍳"
	black $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "$(BOLD_CYAN)ISorting 〽️$(RESET_STYLES)️"
	isort --recursive $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "$(BOLD_CYAN)Flaking️❄️$(RESET_STYLES)"
	flake8 $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "$(BOLD_CYAN)Securing️🕵️️$(RESET_STYLES)"
	bandit -l -i -r . --format=custom

