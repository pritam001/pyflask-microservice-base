pyflask-microservice-base
------------------------------------------------------------------------------
An "optionally opinionated and structured" flask boilerplate microservice for jump-starting development

![Built with](https://img.shields.io/badge/-Built%20with-073551?style=flat-square)
![Python](https://img.shields.io/badge/-Python-3776AB?style=flat-square&logo=Python&logoColor=white)
![Flask](https://img.shields.io/badge/-Flask-000000?style=flat-square&logo=flask&logoColor=white)
![License](https://img.shields.io/github/license/pritam001/pyflask-microservice-base?style=flat-square&label=License)


Project status
------------------------------------------------------------------------------
![WIP](https://img.shields.io/badge/%20%F0%9F%9A%A7%20-Dev%20in%20progress-important)
[![Maintainability](https://api.codeclimate.com/v1/badges/cc34f11b1a2b9bb8e216/maintainability)](https://codeclimate.com/github/pritam001/pyflask-microservice-base/maintainability)
[![codecov](https://codecov.io/gh/pritam001/pyflask-microservice-base/branch/master/graph/badge.svg)](https://codecov.io/gh/pritam001/pyflask-microservice-base)


Tools
------------------------------------------------------------------------------
[![Min Python Version 3.8+](https://img.shields.io/badge/python-3.8+-3776AB.svg?style=flat)](https://www.python.org/download/releases/3.8.0/)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg?style=flat)](https://github.com/psf/black)
[![Static Analysis: flake8](https://img.shields.io/badge/static%20analysis-flake8-cccccc.svg?style=flat)](https://github.com/PyCQA/flake8/)
[![Cyclomatic Complexity: radon](https://img.shields.io/badge/cyclomatic%20complexity-radon-ff5252.svg?style=flat)](https://github.com/rubik/radon)
[![Imports: isort](https://img.shields.io/badge/%20imports-isort-%231674b1?style=flat&labelColor=ef8336)](https://timothycrosley.github.io/isort/)
[![Static Typing: mypy](https://img.shields.io/badge/static%20typing-mypy-blue.svg?style=flat)](https://github.com/python/mypy/)
[![Security: bandit](https://img.shields.io/badge/security-bandit-yellow.svg?style=flat)](https://github.com/PyCQA/bandit)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?style=flat&logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![API Specs](https://img.shields.io/badge/specs-flasgger-6D9A00?style=flat&logo=swagger&logoColor=white)](https://github.com/flasgger/flasgger)
[![Tests: pytest](https://img.shields.io/badge/%20tests-pytest-%23009BDB?style=flat)](https://docs.pytest.org/en/latest/contents.html)
[![Coverage: pytest-cov](https://img.shields.io/badge/%20coverage-pytest--cov-%23009BDB?style=flat)](https://docs.pytest.org/en/latest/contents.html)
[![Version Handling: tbump](https://img.shields.io/badge/%20version%20handling-tbump-%23009BDB?style=flat)](https://docs.pytest.org/en/latest/contents.html)


Usage Guide
------------------------------------------------------------------------------
This is a template project hosted on GitHub which can be used to create new repositories.


### Steps for creating boilerplate project in GitHub
1. Create a new repository named "my-pyflask-project" using this template repository *+
1. `git clone https://www.github.com/username/my-pyflask-project.git`
1. `cd my-pyflask-project`
1. Create and activate conda environment 
   `conda init my-conda-venv`
   `conda activate my-conda-venv` *^
1. `make setup` : Use pip-tools, pip-compile, pip install to setup python packages

*+ [GitHub Guide: Creating a repository from a template](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template)
<br>
*^ [Guide to Conda environment](https://github.com/pritam001/pyflask-microservice-base/blob/master/documentation/wiki/conda.md)


### Make Guide
Type `make help` for available commands

<p align="center"><img src="documentation/assets/make-help.gif" /></p>

Type `make pre-commit` before committing your changes to run formatters, linters, tests and code coverage collectors

<p align="center"><img src="documentation/assets/make-pre-commit.gif" /></p>


### Linting Guide
`make format` : Format and fix python code with black, isort, autoflake and pre-commit hooks

<p align="center"><img src="documentation/assets/make-format.gif" /></p>

`make lint` : Run static analysis with flake8, radon, mypy and bandit

<p align="center"><img src="documentation/assets/make-lint.gif" /></p>


### Documentation
Flasgger docs can be found at http://0.0.0.0:8420/api/v1/pyflask-service/swagger

API specs can be found at http://0.0.0.0:8420/api/v1/pyflask-service/swagger_spec

Flasgger UI version: v2 | OpenAPI version: 2

<p align="center"><img src="documentation/assets/flasgger_intro.png" /></p>


Development Setup
------------------------------------------------------------------------------
To be updated


Contributing
------------------------------------------------------------------------------
1. Stargaze this repository
1. Fork this repository
1. Commit your changes
1. Create pull request to `development` branch

[![](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/images/0)](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/links/0)
[![](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/images/1)](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/links/1)
[![](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/images/2)](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/links/2)
[![](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/images/3)](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/links/3)
[![](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/images/4)](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/links/4)
[![](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/images/5)](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/links/5)
[![](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/images/6)](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/links/6)
[![](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/images/7)](https://sourcerer.io/fame/pritam001/pritam001/pyflask-microservice-base/links/7)


TODO
-----------------------------------------------------------------------------
- [x] Swagger support
- [ ] Update linting documentation
- [x] Introduction of testing tools
- [ ] Testing tools documentation
- [x] Code coverage
- [ ] Version handling by tbump
- [ ] Add CoC, Contribution guidelines, PR and issue templates

