from flasgger import Swagger
from flask import Flask
from flask_cors import CORS

from src.config.dynaconf import settings
from src.config.flasgger import fetch_flasgger_config, fetch_flasgger_template
from src.core import Logger, Singleton

log = Logger()


class Server(metaclass=Singleton):
    def __init__(self):
        app: Flask = Flask(__name__)
        with app.app_context():
            log.info(f"Starting {settings.APP_NAME} server on {settings.API.SERVER}")
        CORS(app)
        self.app: Flask = app
        self.docs: Swagger = Swagger(app, template=fetch_flasgger_template(app), config=fetch_flasgger_config())

    def get_app(self) -> Flask:
        return self.app

    def get_docs(self) -> Swagger:
        return self.docs
