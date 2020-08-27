from test.pytest.test_fixtures import TestFixtures

from src.core import Logger
from src.routes.health import Client

log: Logger = Logger()


class TestRouteCommon(TestFixtures):
    @staticmethod
    def health_url_prefix() -> str:
        return Client.get_url_prefix()

    @staticmethod
    def base_api_url() -> str:
        return Client.get_base_api_url()

    # testing random path to give 404
    def test_random(self, test_client) -> None:
        health_response = test_client.get(self.health_url_prefix() + "/randomized")
        assert health_response.status_code == 404

    # testing ping path to give 200
    def test_health(self, test_client) -> None:
        health_response = test_client.get(self.health_url_prefix() + "/ping")
        assert health_response.status_code == 200

    def test_swagger(self, test_client) -> None:
        swagger_response = test_client.get(self.base_api_url() + "/swagger")
        assert swagger_response.status_code == 200
