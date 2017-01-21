FROM alpine:3.4

RUN apk add --update wget ca-certificates unzip git bash \
    && wget -q -O /terraform.zip "$(wget -q https://www.terraform.io/downloads.html -O - | grep -oE 'https://releases\.hashicorp\.com/terraform/.*_linux_amd64.zip')" \
    && unzip /terraform.zip -d /bin \
    && apk del --purge wget ca-certificates unzip \
    && rm -rf /var/cache/apk/* /terraform.zip \
    && mkdir ~/.aws

VOLUME ["/data", "/root/.aws"]
WORKDIR /data
ENTRYPOINT ["/bin/terraform"]

CMD ["--help"]
