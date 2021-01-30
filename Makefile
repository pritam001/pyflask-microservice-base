# pyflask_config: python_env_name
PYTHON_ENV_NAME=pyflask-base-env
# pyflask_config: service_name
APPLICATION_NAME=pyflask-microservice

APP_DIR=src
TEST_DIR=test
HOME_DIR_PY_FILES=*.py

# echo _FormatCode_ guide:
# 	0 	Reset all styles
# 	1	Bold
#   31  Red
#	32 	Green
#	34 	Blue
#	35 	Magenta
#	36	Cyan
RESET_STYLES=\033[0m
BOLD_RED=\033[1m\033[31m
BOLD_GREEN=\033[1m\033[32m
BOLD_BLUE=\033[1m\033[34m
BOLD_MAGENTA=\033[1m\033[35m
BOLD_CYAN=\033[1m\033[36m

# Signifies our desired python version
# Makefile macros (or variables) are defined a little bit differently than traditional bash, keep in mind that in the Makefile there's top-level Makefile-only syntax, and everything else is bash script syntax.
PYTHON = python3

# .PHONY defines parts of the makefile that are not dependant on any specific file
# This is most often used to store functions
.PHONY = all help init setup upgrade format lint format-n-lint test-n-cover pre-commit debug-run dev-run prod-run clean wipe clean-n-wipe

# Defining an array variable
IGNORED_FILES_AND_FOLDERS = .mypy_cache/ .pytest_cache/ htmlcov/ logs/ .coverage

# Defines the default target that `make` will to try to make, or in the case of a phony target, execute the specified commands
# This target is executed whenever we just type `make`
.DEFAULT_GOAL = help


# The @ makes sure that the command itself isn't echoed in the terminal
help:
	@echo "$(BOLD_BLUE)-----------------------------MAKE GUIDE----------------------------$(RESET_STYLES)"
	@echo "$(BOLD_CYAN)make init$(RESET_STYLES) : Initialize pyflask-microservice"
	@echo "$(BOLD_CYAN)make setup$(RESET_STYLES) : Setup pyflask-microservice"
	@echo "$(BOLD_CYAN)make upgrade$(RESET_STYLES) : Upgrade dependencies of pyflask-microservice"
	@echo "$(BOLD_CYAN)make format$(RESET_STYLES) : Format and fix python code in pyflask-microservice"
	@echo "$(BOLD_CYAN)make lint$(RESET_STYLES) : Lint pyflask-microservice"
	@echo "$(BOLD_CYAN)make format-n-lint$(RESET_STYLES) : Format and lint python code in pyflask-microservice"
	@echo "$(BOLD_CYAN)make test-n-cover$(RESET_STYLES) : Test and code coverage pyflask-microservice"
	@echo "$(BOLD_CYAN)make pre-commit$(RESET_STYLES) : Run pre-commit checks for pyflask-microservice"
	@echo "$(BOLD_CYAN)make debug-run$(RESET_STYLES) : Debug pyflask-microservice"
	@echo "$(BOLD_CYAN)make dev-run$(RESET_STYLES) : Run pyflask-microservice in environment=development"
	@echo "$(BOLD_CYAN)make prod-run$(RESET_STYLES) : Run pyflask-microservice in environment=prod"
	@echo "$(BOLD_CYAN)make clean$(RESET_STYLES) : Clean pyflask-microservice"
	@echo "$(BOLD_CYAN)make wipe$(RESET_STYLES) : Wipe pyflask-microservice"
	@echo "$(BOLD_CYAN)make clean-n-wipe$(RESET_STYLES) : Clean and wipe pyflask-microservice"
	@echo "$(BOLD_BLUE)-------------------------------------------------------------------$(RESET_STYLES)"


init: #: Initialize and personalize python environment
	@echo "\n$(BOLD_BLUE)Initialize pyflask-microservice$(RESET_STYLES)"
	sh scripts/dev/service_init.sh


setup: #: Use pip-tools, pip-compile, pip install
	@echo "\n$(BOLD_BLUE)Setting up pyflask-microservice$(RESET_STYLES)"
	@echo "\n$(BOLD_CYAN)Activating python environment . . .$(RESET_STYLES)"
	sh scripts/dev/activate_python_env.sh
	sh scripts/dev/check_python_env.sh
	@echo "\n$(BOLD_CYAN)Checking dependencies . . .$(RESET_STYLES)"
	sh scripts/dev/check_env_manager.sh
	sh scripts/dev/check_python_version.sh
	@echo "\n$(BOLD_CYAN)Installing pip-tools . . .$(RESET_STYLES)"
	pip3 install pip-tools
	@echo "\n$(BOLD_CYAN)Generating requirements$(RESET_STYLES)"
	pip-compile -q --build-isolation --output-file=requirements/requirements.txt requirements/requirements.in
	@echo "\n$(BOLD_CYAN)Generating dev requirements$(RESET_STYLES)"
	pip-compile -q --build-isolation --output-file=requirements/dev-requirements.txt requirements/dev-requirements.in
	@echo "\n$(BOLD_CYAN)Syncing requirements$(RESET_STYLES)"
	pip-sync requirements/requirements.txt requirements/dev-requirements.txt
	@echo "\n$(BOLD_CYAN)Adding pre-commit hooks$(RESET_STYLES)"
	pre-commit install
	@echo "\n$(BOLD_GREEN)Setup complete$(RESET_STYLES)"


upgrade: #: upgrade requirements to latest versions
	@echo "\n$(BOLD_BLUE)Upgrading dependencies of pyflask-microservice$(RESET_STYLES)"
	python3 -m pip install --upgrade pip
	pip-compile --upgrade requirements/requirements.in --output-file requirements/requirements.txt
	pip-compile --upgrade requirements/dev-requirements.in --output-file requirements/dev-requirements.txt
	@echo "\n$(BOLD_GREEN)Upgrade complete$(RESET_STYLES)"


format: #: Format and fix python code with black, isort, autoflake
	@echo "\n$(BOLD_BLUE)Blackifying$(RESET_STYLES) 🍳"
	black --version
	black $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "\n$(BOLD_CYAN)ISorting$(RESET_STYLES) 〽️️"
	isort $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "\n$(BOLD_CYAN)Flaking$(RESET_STYLES) ❄️"
	flake8 --version
	autoflake --remove-all-unused-imports --remove-unused-variables --remove-duplicate-keys --ignore-init-module-imports -i -r $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)


lint: #: Run static analysis with flake8, radon, mypy and bandit
	@echo "\n$(BOLD_CYAN)Linting with flake8$(RESET_STYLES) ❄️"
	flake8 --version
	flake8 $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES)
	@echo "\n$(BOLD_CYAN)Checking cyclomatic complexity with radon$(RESET_STYLES) 💫️"
	radon --version
	radon cc $(APP_DIR) $(TEST_DIR) $(HOME_DIR_PY_FILES) --total-average -nc
	@echo "\n$(BOLD_CYAN)Static typing with mypy$(RESET_STYLES) ⌨️"
	mypy --version
	mypy $(APP_DIR) $(HOME_DIR_PY_FILES)
	@echo "\n$(BOLD_CYAN)Securing with bandit$(RESET_STYLES) 🕵️️"
	bandit --version
	bandit -l -i -r . --format=custom  -c .bandit.yml -x ./$(TEST_DIR),./$(PYTHON_ENV_NAME)
	@echo "\n"


format-n-lint: #: Format and lint
	make --no-print-directory format
	make --no-print-directory lint
	@echo "\n"


test-n-cover: #: Test with pytest, Code coverage with pytest-cov plugin
	@echo "\n$(BOLD_BLUE)Testing with pytest$(RESET_STYLES) 📊️"
	pytest --version
	pytest
	@echo "\n"


pre-commit: #: Run pre-commit checks : format, lint, test, cover
	@echo "\n$(BOLD_BLUE)Starting pre-commit jobs . . .$(RESET_STYLES)"
	make --no-print-directory format-n-lint
	@echo "\n$(BOLD_CYAN)Running pre-commit hooks$(RESET_STYLES) 🏁️️️"
	pre-commit run --all-files
	@echo "\n$(BOLD_GREEN)All checks passed$(RESET_STYLES) 🏳️️️️"
	make --no-print-directory test-n-cover
	@echo "\n$(BOLD_GREEN)Pre-commit jobs completed$(RESET_STYLES) 👍"


debug-run: #: Run application in debug mode
	@echo "\n$(BOLD_BLUE)Starting application in debug mode . . .$(RESET_STYLES)"
	FLASK_ENV=development python3 service_master.py


dev-run: #: Run application in dev mode
	@echo "\n$(BOLD_BLUE)Starting application in dev mode . . .$(RESET_STYLES)"
	FLASK_ENV=development python3 service_master.py


prod-run: #: Run application in prod mode
	@echo "\n$(BOLD_BLUE)Starting application in prod mode . . .$(RESET_STYLES)"
	FLASK_ENV=prod python3 service_master.py


docker-build: #: Build docker image for the application
	@echo "\n$(BOLD_BLUE)Building docker image . . .$(RESET_STYLES)"


docker-start: #: Start docker image for the application
	@echo "\n$(BOLD_BLUE)Starting dockerized application . . .$(RESET_STYLES)"


clean: #: Clean unnecessary files
	@echo "\n$(BOLD_CYAN)Cleaning unnecessary files$(RESET_STYLES) 🚿"
	rm -rf $(IGNORED_FILES_AND_FOLDERS)


wipe: #: Wipe python environment
	@echo "\n$(BOLD_CYAN)Wiping environment$(RESET_STYLES) 🚿"
	sh scripts/dev/service_wipe.sh


clean-n-wipe: #: Clean project and wipe environment
	@echo "\n$(BOLD_BLUE)Cleaning up project and wiping environment$(RESET_STYLES)"
	make --no-print-directory clean
	make --no-print-directory wipe

