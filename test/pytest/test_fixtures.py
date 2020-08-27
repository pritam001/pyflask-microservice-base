import pytest
from flask import Flask
from flask.testing import FlaskClient

from src.app import app


class TestFixtures:
    @pytest.fixture
    def flask_app(self) -> Flask:
        return app

    @pytest.fixture
    def test_client(self, flask_app) -> FlaskClient:
        return app.test_client()

    @pytest.fixture
    def test_cli_runner(self, flask_app):
        return app.test_cli_runner()
