#!/usr/bin/env python

import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
import requests
from tornado.options import define, options

define("port", default=9000, help="run on the given port", type=int)

class MainHandler(tornado.web.RequestHandler):
    @tornado.gen.coroutine
    def get(self):
        response = {
            "type": "app",
            "version": "0.2"
        }
        self.write(response)

class GetIpHandler(tornado.web.RequestHandler):
    @tornado.gen.coroutine
    def get(self):
        ip = requests.get('http://checkip.amazonaws.com/')
        response = {
            "type": "app",
            "version": "0.2",
            "public-ip": ip.text.replace('\n', '')
        }
        self.write(response)

class GetHeaderHandler(tornado.web.RequestHandler):
    @tornado.gen.coroutine
    def initialize(self, *args, **kwargs):
        self.remote_ip = self.request.headers.get('X-Forwarded-For', self.request.headers.get('X-Real-Ip', self.request.remote_ip))
        self.using_ssl = (self.request.headers.get('X-Scheme', 'http') == 'https')
    def get(self):
        self.write("Hello " + ("s" if self.using_ssl else "") + " " + self.remote_ip)

def main():
    tornado.options.parse_command_line()
    application = tornado.web.Application([
        (r"/", MainHandler),
        (r"/ip", GetIpHandler),
        (r"/header", GetHeaderHandler),
    #], autoreload = True)
    ])
    http_server = tornado.httpserver.HTTPServer(application)
    http_server.listen(options.port)
    tornado.ioloop.IOLoop.current().start()

if __name__ == "__main__":
    main()
