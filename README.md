pyflask-microservice-base
------------------------------------------------------------------------------
An "optionally opinionated and structured" flask boilerplate microservice for jump-starting development

![Built with](https://img.shields.io/badge/-Built%20with-073551?style=flat-square)
![Python](https://img.shields.io/badge/-Python-3776AB?style=flat-square&logo=Python&logoColor=white)
![Flask](https://img.shields.io/badge/-Flask-000000?style=flat-square&logo=flask&logoColor=white)
![License](https://img.shields.io/github/license/pritam001/pyflask-microservice-base?style=flat-square&label=License)
![WIP](https://img.shields.io/badge/%20%F0%9F%9A%A7%20-Dev%20in%20progress-important)


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


Usage Guide
------------------------------------------------------------------------------
This is a template project hosted on GitHub which can be used to create new repositories.


Steps for creating boilerplate project in GitHub
------------------------------------------------------------------------------
0. Create a new repository named "my-pyflask-project" using this template repository *
0. `git clone https://www.github.com/username/my-pyflask-project.git`
0. `cd my-pyflask-project`
0. Create and activate conda environment `conda activate my-conda-venv` **
0. `make setup` : Use pip-tools, pip-compile, pip install to setup python packages

\* [GitHub Guide: Creating a repository from a template](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-from-a-template)
<br>
\** [Guide to Conda environment](https://github.com/pritam001/pyflask-microservice-base/blob/master/documentation/conda.md)


Make Guide
------------------------------------------------------------------------------
Type `make help` for available commands

<p align="center"><img src="documentation/assets/make-help.gif" /></p>


Linting Guide
------------------------------------------------------------------------------
`make format` : Format and fix python code with black, isort, autoflake

<p align="center"><img src="documentation/assets/make-format.gif" /></p>

`make lint` : Run static analysis with flake8, radon, mypy and bandit

<p align="center"><img src="documentation/assets/make-lint.gif" /></p>