from src.core import Logger
from src.routes import register_blueprints
from src.server import Server

log = Logger()

log.info("Creating app instance . . .")
server = Server()  # Generate singleton instance of server
app = server.get_app()  # Get Flask app reference from server instance
log.info("Registering blueprints . . .")
register_blueprints(app)  # Register all blueprints to app reference
