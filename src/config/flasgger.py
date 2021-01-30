from typing import Any, Dict

from apispec.ext.marshmallow import MarshmallowPlugin
from flasgger import APISpec

from src.config.dynaconf import settings


def fetch_flasgger_template(app) -> Dict[Any, dict]:
    # Create an APISpec
    title: str = settings.APP_NAME.replace("-", " ")
    version: str = settings.VERSION
    spec: APISpec = APISpec(title=title, version=version, openapi_version="3.0", plugins=[MarshmallowPlugin()])

    template: Dict[Any, dict] = spec.to_flasgger(app, definitions=[], paths=[])
    return template


def fetch_flasgger_config() -> Dict[str, Any]:
    title: str = settings.APP_NAME.replace("-", " ")
    base_api_url: str = settings.API.VERSION + settings.APP_NAME
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
