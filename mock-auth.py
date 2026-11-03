from http.server import HTTPServer, BaseHTTPRequestHandler
import json


class H(BaseHTTPRequestHandler):
    def do_POST(self):
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.end_headers()
        self.wfile.write(
            json.dumps(
                {
                    "api_key": "container-key",
                    "key_id": "container",
                    "enabled": True,
                }
            ).encode()
        )

    def log_message(self, format, *args):
        return


HTTPServer(("0.0.0.0", 9999), H).serve_forever()
