FROM node:19-alpine3.15 as base_image

RUN npm install -g npm \
    && npm cache clean --force \
    && npm install -g @angular/cli

WORKDIR /app

FROM base_image as development
COPY ./containers/node/entrypoint.development.sh /entrypoint/runner.sh
RUN chmod +x /entrypoint/runner.sh
ENTRYPOINT ["tail", "-f", "/dev/null"]

FROM base_image as init
COPY ./containers/node/entrypoint.init.sh /entrypoint/entrypoint.sh
RUN chmod +x /entrypoint/entrypoint.sh
ENTRYPOINT ["sh", "/entrypoint/entrypoint.sh"]
