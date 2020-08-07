#!/usr/bin/env bash

echo "Welcome to pyflask base constructor"

# Check for venv, conda else exit

echo "Installing pip-tools . . ."
pip install pip-tools

echo "Generating requirements"
pip-compile --output-file=requirements/requirements.txt requirements/requirements.in

echo "Generating dev requirements"
pip-compile --output-file=requirements/dev-requirements.txt requirements/dev-requirements.in

echo "Installing requirements"
pip install -r requirements/requirements.txt

echo "Installing dev requirements"
pip install -r requirements/dev-requirements.txt
