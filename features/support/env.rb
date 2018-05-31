require 'cucumber'
require 'rspec/expectations'
require 'selenium-webdriver'
require 'capybara/cucumber'
require 'site_prism'
require 'require_all'

require_all 'pages'
Capybara.app_host = 'https://www.google.com/?hl=en'

caps = Selenium::WebDriver::Remote::Capabilities.new
caps["browserName"] = "chrome"
caps["version"] = "66.0"
caps["enableVNC"] = true

Capybara.default_driver = :remote
Capybara.register_driver :remote do |app|
  Capybara::Selenium::Driver.new(app, browser: :remote,
                                 :url => "http://209.97.133.6:4444/wd/hub",
                                 :desired_capabilities => caps)
end

# Capybara.default_driver = :selenium
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, browser: :chrome)
# end

Before do
  # set screen resolution
  Capybara.page.driver.browser.manage.window.resize_to(1920, 1080)
end

After do
  # setting Capybara driver to reset sessions after all tests are done
  Capybara.reset_sessions!
end