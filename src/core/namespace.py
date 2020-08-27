from dynaconf import settings
from flask import Blueprint


class Namespace(object):
    def __init__(self, path: str):
        self.base_api_url: str = settings.API.VERSION + settings.APP_NAME
        self.path: str = path
        self.url_prefix: str = self.base_api_url + "/" + path
        self.api: Blueprint = Blueprint(path, __name__, url_prefix=self.url_prefix)

    def get_url_prefix(self) -> str:
        return self.url_prefix
