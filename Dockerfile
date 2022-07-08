FROM registry.fedoraproject.org/fedora-minimal:35

SHELL ["/bin/bash", "-l", "-c"]

RUN microdnf --nodocs -y upgrade && \
    microdnf --nodocs -y install \
    nginx \
    tar && \
    microdnf clean all && \
    rm -f /etc/nginx/nginx.conf.default

COPY nginx.conf /etc/nginx/nginx.conf

USER nginx

CMD ["nginx", "-g", "daemon off;", "-e", "/dev/stderr"]
