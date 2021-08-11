FROM nginxinc/nginx-unprivileged:1-alpine
LABEL maintainer="voka"

COPY ./default.conf.tpl /etc/nginx/default.conf.tpl
COPY ./uwsgi_aparams /etc/nginx/uwsgi_params
COPY ./run.sh /run.sh

ENV LISTEN_PORT=8000
ENV APP_HOST=molp_project
ENV APP_PORT=9000

USER root

RUN mkdir -p /vol/static && \
    chmod 755 /vol/static && \
    touch /etc/nginx/conf.d/default.conf && \
    chown nginx:nginx /etc/nginx/conf.d/default.conf && \
    chmod +x /run.sh

VOLUME /vol/static

CMD ["/run.sh"]

USER nginx