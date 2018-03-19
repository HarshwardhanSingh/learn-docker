FROM ubuntu:latest

# USER root

RUN apt-get update
RUN apt-get install -y -q software-properties-common wget

# firefox
RUN add-apt-repository -y ppa:mozillateam/firefox-next
RUN apt-get update -y
RUN apt-get install firefox -y

# basics
RUN apt-get install -y nginx openssh-server git-core openssh-client curl
RUN apt-get install -y nano
RUN apt-get install -y build-essential
RUN apt-get install -y openssl libreadline6 libreadline6-dev curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config gnupg2 rubygems ruby2.3-dev xvfb

# install RVM, Ruby, and Bundler
RUN gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
RUN \curl -L https://get.rvm.io | bash -s stable
RUN /bin/bash -l -c "rvm requirements"
RUN /bin/bash -l -c "rvm install 2.1"
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && chmod +x /opt/geckodriver \
  && mv /opt/geckodriver /usr/bin/geckodriver

ENV RACK_ENV production
ENV MAIN_APP_FILE main.rb

RUN mkdir -p /usr/src/app
ADD startup.sh /

WORKDIR /usr/src/app

EXPOSE 80

CMD ["/bin/bash", "/startup.sh"]
