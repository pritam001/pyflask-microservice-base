from typing import Dict

from flasgger import swag_from
from flask import Blueprint

from src.core import Logger, Namespace

Client: Namespace = Namespace("health")
api: Blueprint = Client.api
log: Logger = Logger()


@api.route("/ping", methods=["GET"])
@swag_from("specs/health.yml")
def get_health() -> Dict[str, str]:
    log.info("Request received : ping")
    return {"status": "UP"}
