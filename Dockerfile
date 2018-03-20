FROM ubuntu:latest

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get install -y -q software-properties-common wget
RUN add-apt-repository -y ppa:mozillateam/firefox-next
RUN apt-add-repository ppa:brightbox/ruby-ng
RUN apt-get update -y
RUN apt-get install firefox -y
RUN apt-get install xvfb -y
RUN apt-get install -y build-essential
RUN apt-get install ruby2.4 ruby2.4-dev -y

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
