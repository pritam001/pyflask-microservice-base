from dynaconf import settings
from flasgger import Swagger
from flask import Flask
from flask_cors import CORS

from src.config.flasgger import fetch_flasgger_template
from src.core import Logger, Singleton

log = Logger()


class Server(metaclass=Singleton):
    def __init__(self):
        app = Flask(__name__)
        with app.app_context():
            log.info(f"Starting {settings.APP_NAME} server on {settings.API.SERVER}")
        CORS(app)
        self.app = app
        self.docs = Swagger(app, template=fetch_flasgger_template(app))

    def get_app(self):
        return self.app

    def get_docs(self):
        return self.docs
