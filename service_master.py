from dynaconf import settings

from src.app import app
from src.core import Logger

log: Logger = Logger()


if __name__ == "__main__":
    log.info("Created app instance. Initiating run . . . ")
    app.run(
        host=settings.API.SERVER.url,
        port=settings.API.SERVER.port,
        debug=settings.DEBUG,
    )
