from dynaconf import settings
from flask import Flask
from flask_apispec import FlaskApiSpec
from flask_cors import CORS

from src.core import Logger, Singleton

log = Logger()


class Server(metaclass=Singleton):
    def __init__(self):
        app = Flask(__name__)
        with app.app_context():
            log.info(f"Starting {settings.APP_NAME} server on {settings.API.SERVER}")
        CORS(app)
        self.app = app
        self.docs = FlaskApiSpec(app)

    def get_app(self):
        return self.app

    def get_docs(self):
        return self.docs
