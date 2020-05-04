FROM nginx

RUN mv /etc/nginx/conf.d/default.conf  /etc/nginx/conf.d/default.conf.disabled

COPY assets /assets

ENV URI_SECRETS 'URI_SECRETS'

EXPOSE 80

STOPSIGNAL SIGTERM

CMD [ "/assets/run.sh" ]