from dynaconf import settings
from flask import Blueprint


class Namespace(object):
    def __init__(self, path: str):
        self.base_api_url: str = settings.API.VERSION + settings.APP_NAME
        self.path: str = path
        self.api: Blueprint = Blueprint(path, __name__, url_prefix=self.base_api_url + "/" + path)
