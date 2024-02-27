server {
  listen 443 ssl;
  http2 on;

  server_name {{ env "FQDN" }};

  ssl_certificate     /etc/nginx/cert.pem;
  ssl_certificate_key /etc/nginx/key.pem;

  location / {
    proxy_pass http://backend_server;
  }
}
