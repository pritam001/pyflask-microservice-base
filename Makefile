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
.PHONY = help setup format lint test debug clean

# Defining an array variable
FILES = input output

# Defines the default target that `make` will to try to make, or in the case of a phony target, execute the specified commands
# This target is executed whenever we just type `make`
.DEFAULT_GOAL = help


# The @ makes sure that the command itself isn't echoed in the terminal
help:
	@echo "$(BOLD_BLUE)-----------------------------MAKE GUIDE----------------------------$(RESET_STYLES)"
	@echo "$(BOLD_CYAN)make setup$(RESET_STYLES) : Setup pyflask-service"
	@echo "$(BOLD_CYAN)make format$(RESET_STYLES) : Format and fix python code pyflask-service"
	@echo "$(BOLD_CYAN)make lint$(RESET_STYLES) : Lint pyflask-service"
	@echo "$(BOLD_CYAN)make test$(RESET_STYLES) : Test pyflask-service"
	@echo "$(BOLD_CYAN)make debug$(RESET_STYLES) : Debug pyflask-service"
	@echo "$(BOLD_CYAN)make clean$(RESET_STYLES) : Clean pyflask-service"
	@echo "$(BOLD_CYAN)make dev-run$(RESET_STYLES) : Run pyflask-service in environment=development"
	@echo "$(BOLD_CYAN)make prod-run$(RESET_STYLES) : Run pyflask-service in environment=prod"
	@echo "$(BOLD_BLUE)-------------------------------------------------------------------$(RESET_STYLES)"


setup: #: Use pip-tools, pip-compile, pip install
	@echo "$(BOLD_CYAN)Setting up pyflask base$(RESET_STYLES)"
	# Check for venv, conda else exit
	@echo "$(BOLD_CYAN)Installing pip-tools . . .$(RESET_STYLES)"
	pip install pip-tools
	@echo "$(BOLD_CYAN)Generating requirements$(RESET_STYLES)"
	pip-compile -q --build-isolation --output-file=requirements/requirements.txt requirements/requirements.in
	@echo "$(BOLD_CYAN)Generating dev requirements$(RESET_STYLES)"
	pip-compile -q --build-isolation --output-file=requirements/dev-requirements.txt requirements/dev-requirements.in
	@echo "$(BOLD_CYAN)Syncing requirements$(RESET_STYLES)"
	pip-sync -q requirements/requirements.txt requirements/dev-requirements.txt
	@echo "$(BOLD_CYAN)Installing requirements$(RESET_STYLES)"
	pip install -r requirements/requirements.txt
	@echo "$(BOLD_CYAN)Installing dev requirements$(RESET_STYLES)"
	pip install -r requirements/dev-requirements.txt
	@echo "$(BOLD_CYAN)Adding pre-commit hooks$(RESET_STYLES)"
	pre-commit install


format: #: Format and fix python code with black, isort, autoflake
	@echo "$(BOLD_CYAN)Blackifying $(RESET_STYLES)🍳"
	black --version
	black $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "$(BOLD_CYAN)ISorting 〽️$(RESET_STYLES)️"
	isort --recursive $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "$(BOLD_CYAN)Flaking️❄️$(RESET_STYLES)"
	flake8 --version
	autoflake --remove-all-unused-imports --remove-unused-variables --remove-duplicate-keys --ignore-init-module-imports -i -r $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)


lint: #: Run static analysis with flake8, mypy and bandit
	@echo "$(BOLD_CYAN)Flake linting ❄️$(RESET_STYLES)"
	flake8 --version
	flake8 $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "$(BOLD_CYAN)Static typing️️$(RESET_STYLES)⌨️"
	mypy --version
	mypy $(APP_DIR) $(HOME_DIR_PY_FILES)
	@echo "$(BOLD_CYAN)Securing with bandit️🕵️️$(RESET_STYLES)"
	bandit --version
	bandit -l -i -r . --format=custom
	@echo "$(BOLD_CYAN)Running pre-commit hooks 🏁️️️$(RESET_STYLES)"
	pre-commit run --all-files
	@echo "$(BOLD_CYAN)All checks passed 🏳️️️️$(RESET_STYLES)"

