# docker-nginx

This repository provides Fedora-based Nginx Docker images. Dockerfiles are built and hosted using GitHub-provided services (Actions and Packages).

## How to use

To build a React-based client-side rendered single page application, use the following Dockerfile.

```Dockerfile
FROM ghcr.io/shoraiconsulting/node:16 as dev

ARG UID=1000
ENV UID=${UID}

RUN useradd -d /app -l -m -Uu ${UID} -r -s /bin/bash node && \
  chown -R node:node /app

USER node
ENV LANG C.UTF-8

WORKDIR /app
COPY --chown=node:node package.json package-lock.json /app/
RUN npm install -q

# Copy application
COPY --chown=node:node . /app/

RUN npm run build

FROM ghcr.io/shoraiconsulting/nginx:latest as prod

COPY --from=dev --chown=nginx:nginx /app/build/ /usr/share/nginx/html
```
