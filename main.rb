require 'sinatra'
require 'selenium-webdriver'
require 'headless'

get '/' do
  url = params[:url]
  width = 1024
  height = 728
  headless = Headless.new(display: 99)
  headless.start
  driver = Selenium::WebDriver.for :firefox
  driver.navigate.to url
  driver.execute_script %Q{
    window.resizeTo(#{width}, #{height});
  }
  driver.save_screenshot('screenshot.png')
  driver.quit
  headless.destroy
  send_file("screenshot.png")
end