require 'cucumber'
require 'rspec/expectations'
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'site_prism'
require 'require_all'

require_all 'pages'

Capybara.app_host = 'https://www.google.com/?hl=en'
Capybara.default_driver = :selenium
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Before do
  # set screen resolution
  Capybara.page.driver.browser.manage.window.resize_to(1024, 768)
end

After do
  # setting Capybara driver to reset sessions after all tests are done
  Capybara.reset_sessions!
end