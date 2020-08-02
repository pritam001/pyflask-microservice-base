from src.core import Logger
from .health import api as health_blueprint

log = Logger()


def register_blueprints(app):
    app.register_blueprint(health_blueprint)
    log.info(f"Registered health blueprint")
