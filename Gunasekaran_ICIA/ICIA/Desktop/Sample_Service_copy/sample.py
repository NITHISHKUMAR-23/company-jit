from http.server import BaseHTTPRequestHandler, HTTPServer

HOST = '0.0.0.0'
PORT = 3000

class MyHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(b"<h1>Hello</h1>")

def main():
    server = HTTPServer((HOST, PORT), MyHandler)
    print(f"Server running at http://localhost:{PORT}")
    server.serve_forever()

if __name__ == "__main__":
    main()