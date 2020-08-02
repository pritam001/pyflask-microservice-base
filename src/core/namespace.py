from flask import Blueprint
from dynaconf import settings


class Namespace(object):
    def __init__(self, path=None):
        self.base_api_url = settings.API.VERSION + settings.APP_NAME
        self.path = path
        self.api = Blueprint(path, __name__, url_prefix=self.base_api_url + "/" + path)
