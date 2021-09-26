// Server libs
#include <nghttp2/asio_http2_server.h>

// Standard libs
#include <fstream>
#include <iostream>

#include <chrono>
#include <sys/time.h>
#include <ctime>

#include <thread>

//namespaces
using namespace nghttp2::asio_http2;
using namespace nghttp2::asio_http2::server;

namespace ba = boost::asio;
namespace
{
  // server push demonstration constants
  static const auto html = R"(
      <!DOCTYPE html>
      <html lang="en">
        <title>HTTP/2 FTW</title>
        <body>
          <link href="/style.css" rel="stylesheet" type="text/css">
          <h1>This should be green</h1>
        </body>
      </html>\n)";

  static const auto css = "h1 { color: green; }";

}

int main(int argc, char *argv[]) {
  boost::system::error_code ec;
  http2 server;

  // Concurrency
  //unsigned int cores = std::thread::hardware_concurrency();
  //server.num_threads((cores?cores:1));

  // Server push resource
  server.handle("/serverpush", [](const request &req, const response &res) {
    std::cout << "Got a /serverpush request!" << std::endl;
    boost::system::error_code ec;
    auto push = res.push(ec, "GET", "/style.css");
    push->write_head(200);
    push->end(css);
    res.write_head(200);
    res.end(html);
  });

  // Normal application/json resource
  server.handle("/", [](const request &req, const response &res) {
    std::cout << "Got a / request!" << std::endl;
    nghttp2::asio_http2::header_map headers;
    headers.insert(
      std::make_pair<std::string, nghttp2::asio_http2::header_value>(
        "content-type",
        {"application/json; charset=utf-8",false}));
    res.write_head(200,headers);
    res.end("{\"SERVER\":\"UP\"}\n");
  });

  // TLS context for HTTP/2
  boost::asio::ssl::context tlsCtx(boost::asio::ssl::context::sslv23);
  tlsCtx.use_private_key_file("/usr/local/share/ca-certificates/cpphttp2server.key",
                              boost::asio::ssl::context::pem);
  tlsCtx.use_certificate_chain_file("/usr/local/share/ca-certificates/cpphttp2server.crt");
  configure_tls_context_easy(ec, tlsCtx);

  std::cout << "STARTING HTTP/2 CPP server!" << std::endl;
  //std::cout << "STARTING HTTP/2 CPP server WITH " << cores << " concurrent threads!" << std::endl;
  if (server.listen_and_serve(ec,tlsCtx, "0.0.0.0", "3000")) {
    std::cerr << "error: " << ec.message() << std::endl;
  }

}