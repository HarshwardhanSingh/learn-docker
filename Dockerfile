FROM ubuntu:latest

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get install -y -q software-properties-common wget \
  && add-apt-repository -y ppa:mozillateam/firefox-next \
  && apt-add-repository ppa:brightbox/ruby-ng \
  && apt-get update \
  && apt-get install -y firefox build-essential ruby2.4 ruby2.4-dev xvfb

RUN wget --no-verbose -O /tmp/geckodriver.tar.gz https://github.com/mozilla/geckodriver/releases/download/v0.19.1/geckodriver-v0.19.1-linux64.tar.gz \
  && rm -rf /opt/geckodriver \
  && tar -C /opt -zxf /tmp/geckodriver.tar.gz \
  && rm /tmp/geckodriver.tar.gz \
  && chmod +x /opt/geckodriver \
  && mv /opt/geckodriver /usr/bin/geckodriver

ENV RACK_ENV production
ENV MAIN_APP_FILE main.rb

RUN mkdir -p /usr/src/app
ADD . /usr/src/app
WORKDIR /usr/src/app
RUN /bin/bash -l -c "gem install bundler"
RUN /bin/bash -l -c "bundle install"

EXPOSE 80

CMD ["/bin/bash", "startup.sh"]
