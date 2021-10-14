FROM golang:1.16-alpine

COPY . /go/src/github.com/cyverse-de/job-status-listener

# copy config file 
COPY jobservices.yml /etc/iplant/de/jobservices.yml

WORKDIR /go/src/github.com/cyverse-de/job-status-listener
ENV CGO_ENABLED=0
RUN go install -v github.com/cyverse-de/job-status-listener

EXPOSE 60020
ENTRYPOINT ["job-status-listener", "--config", "/etc/iplant/de/jobservices.yml"]
# CMD ["--help"]

ARG git_commit=unknown
ARG version="2.9.0"
ARG descriptive_version=unknown

LABEL org.label-schema.vcs-url="https://github.com/cyverse-de/job-status-listener"
LABEL org.label-schema.vcs-ref="$git_commit"
LABEL org.label-schema.version="$descriptive_version"
LABEL org.cyverse.git-ref="$git_commit"
LABEL org.cyverse.version="$version"
LABEL org.cyverse.descriptive-version="$descriptive_version"

# build
# docker build -t mbwali/job-status-listener:latest .

# run
# docker run -it -p 60020:60020 mbwali/job-status-listener:latest 

# config
# /etc/iplant/de/jobservices.yml
