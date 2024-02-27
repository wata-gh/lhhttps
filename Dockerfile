FROM 'nginx:latest'

RUN apt update && apt install -y procps zip

ADD cert.pem /etc/nginx
ADD key.pem /etc/nginx
ADD nginx.conf.tpl /
ADD ssl.conf.tpl /

RUN curl -o consul-template_0.37.1_linux_arm64.zip https://releases.hashicorp.com/consul-template/0.37.1/consul-template_0.37.1_linux_arm64.zip
RUN unzip consul-template_0.37.1_linux_arm64.zip

EXPOSE 80
EXPOSE 443

CMD /consul-template -template "nginx.conf.tpl:/etc/nginx/nginx.conf" -template "ssl.conf.tpl:/etc/nginx/conf.d/ssl.conf" -once && /usr/sbin/nginx -g 'daemon off;'
