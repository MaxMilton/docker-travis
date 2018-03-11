# Run the travis CLI via a container
#
# Build image:
#   docker build -t local/travis .
#
# Update:
#   docker build --no-cache -t local/travis .
#

FROM ruby:alpine@sha256:1d35d83403ab30d3f6d93df194fd830286e0f26d8d26e2748d46f6307c40d7e7

RUN set -xe \
  && apk add --no-cache --virtual .build-deps \
    build-base \
    git \
  && gem install travis \
  && gem install travis-lint \
  && apk del .build-deps \
  # && mkdir project \
  # unset SUID on all files
  && for i in $(find / -perm /6000 -type f); do chmod a-s $i; done

# VOLUME ["/project"]

WORKDIR project

ENTRYPOINT ["travis"]