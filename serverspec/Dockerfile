FROM ruby:2.1
ADD Gemfile /usr/src/app/Gemfile
WORKDIR /usr/src/app
RUN bundle

ADD Rakefile /usr/src/app/Rakefile

#Used for access to docker.sock on CoreOS
RUN useradd -u 1000 jenkins && groupadd -g 233 docker && adduser jenkins docker
#Used for access on docker-machine
RUN adduser jenkins users

USER jenkins

ENTRYPOINT ["/usr/local/bin/rake"]
CMD ["spec"]
