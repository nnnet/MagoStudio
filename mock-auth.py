from http.server import HTTPServer, BaseHTTPRequestHandler
import json


class H(BaseHTTPRequestHandler):
    def _send_cors(self, code=200, body=None):
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Access-Control-Allow-Origin", "*")
        self.send_header("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, DELETE")
        self.send_header("Access-Control-Allow-Headers", "Content-Type, Authorization, X-API-Key")
        self.end_headers()
        if body is not None:
            self.wfile.write(json.dumps(body).encode())

    def do_OPTIONS(self):
        self._send_cors(200)

    def do_GET(self):
        if self.path == "/balance":
            self._send_cors(200, {"balance": 0, "currency": "USD"})
        elif self.path == "/auth":
            self._send_cors(200, {"api_key": "container-key", "key_id": "container", "enabled": True})
        else:
            self._send_cors(200, {"ok": True})

    def do_POST(self):
        if self.path == "/auth":
            self._send_cors(200, {"api_key": "container-key", "key_id": "container", "enabled": True})
        else:
            self._send_cors(200, {"ok": True})

    def log_message(self, format, *args):
        return


HTTPServer(("0.0.0.0", 9999), H).serve_forever()
