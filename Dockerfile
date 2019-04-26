FROM hmcts/curl

RUN apk add --no-cache jq

## Add the wait script to the image
ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.2.1/wait /wait

COPY scripts /scripts

RUN ["chmod", "+x", "/wait"]

RUN chmod +x /scripts/*.sh

ENTRYPOINT []

CMD "/wait" && "/scripts/setup.sh"