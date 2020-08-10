from apispec.ext.marshmallow import MarshmallowPlugin
from dynaconf import settings
from flasgger import APISpec


def fetch_flasgger_template(app):
    # Create an APISpec
    title = settings.APP_NAME.replace("-", " ")
    spec = APISpec(title=title, version="1.0.10", openapi_version="2.0", plugins=[MarshmallowPlugin()])

    template = spec.to_flasgger(app, definitions=[], paths=[])
    return template
