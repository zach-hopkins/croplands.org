# Builder
FROM usgsastro/debian:8

ENV NODE_VERSION 12.16.3
ENV PIP_CERT /etc/ssl/certs/ca-certificates.crt
ENV REQUESTS_CA_BUNDLE /etc/ssl/certs/ca-certificates.crt

SHELL ["/bin/bash", "-c"]

RUN apt-get update && \
    apt-get install -y \
        python \
        python-pip \
    && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

RUN useradd -m appuser

WORKDIR /home/appuser/app
COPY requirements.txt .
COPY croplands-web/ .
RUN chown -R appuser:appuser .

USER appuser

ENV PATH "/home/appuser/.local/bin:$PATH"
RUN pip install --user -U pip 'setuptools<45' && \
    pip install --user virtualenv 'zipp<2' && \
    virtualenv .env
RUN source .env/bin/activate && \
    pip install -r requirements.txt

USER root
ADD https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz /tmp/node.tar.gz
RUN chown appuser:appuser /tmp/node.tar.gz

USER appuser
RUN mkdir ~/.local/node && tar xvf /tmp/node.tar.gz -C ~/.local/node --strip-components 1

ENV PATH "/home/appuser/app/.env/bin:/home/appuser/.local/node/bin:$PATH"

RUN npm config set cafile "/etc/ssl/certs/ca-certificates.crt" && npm i && npx grunt

EXPOSE 8000
CMD gunicorn herokuapp:app -b :8000 --workers=2 -k gevent -t 45 --log-level=DEBUG
