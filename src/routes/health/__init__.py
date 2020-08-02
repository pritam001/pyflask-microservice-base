from src.core import Logger, Namespace

Client = Namespace("health")
api = Client.api
log = Logger()


@api.route("/ping", methods=["GET"])
def get_health():
    log.info("Request received : ping")
    return {"statusCode": 200}

