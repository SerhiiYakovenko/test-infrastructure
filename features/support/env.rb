require 'cucumber'
require 'rspec/expectations'
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'site_prism'
require 'require_all'

require_all 'pages'

Capybara.app_host = 'https://www.google.com/?hl=en'
Capybara.default_max_wait_time = 2
Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Before do
  #Make fullscreen
  Capybara.page.driver.browser.manage.window.maximize
end

After do
  # setting Capybara driver to reset sessions after all tests are done
  Capybara.reset_sessions!
end