#!/bin/bash
gem install sinatra
gem install selenium-webdriver
gem install headless -v 2.2.3

bundle install

ruby $MAIN_APP_FILE -p 80

