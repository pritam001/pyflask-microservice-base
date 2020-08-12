from apispec.ext.marshmallow import MarshmallowPlugin
from dynaconf import settings
from flasgger import APISpec


def fetch_flasgger_template(app):
    # Create an APISpec
    title = settings.APP_NAME.replace("-", " ")
    version = settings.VERSION
    spec = APISpec(title=title, version=version, openapi_version="3.0", plugins=[MarshmallowPlugin()])

    template = spec.to_flasgger(app, definitions=[], paths=[])
    return template


def fetch_flasgger_config():
    title = settings.APP_NAME.replace("-", " ")
    base_api_url = settings.API.VERSION + settings.APP_NAME
    return {
        "headers": [],
        "title": title,
        "description": "",
        "termsOfService": "",
        "specs": [
            {
                "endpoint": "swagger_spec",
                "route": f"{base_api_url}/swagger_spec",
                "rule_filter": lambda rule: True,  # all in
                "model_filter": lambda tag: True,  # all in
            }
        ],
        "static_url_path": "/flasgger_static",
        "swagger_ui": True,
        "specs_route": f"{base_api_url}/swagger",
    }
