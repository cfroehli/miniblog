# frozen_string_literal: true

require 'test_helper'

Capybara.default_max_wait_time = 15 if ENV['TRAVIS']

if ENV['USE_SELENIUM_CONTAINERS']
  class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
    include Devise::Test::IntegrationHelpers
    capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
      chromeOptions: { args: %w[no-sandbox disable-gpu disable-dev-shm-usage] }
    )
    driven_by :selenium,
              using: :headless_chrome,
              screen_size: [1280, 1024],
              options: {
                url: 'http://selenium-server:4444/wd/hub',
                desired_capabilities: capabilities,
              }

    def setup
      Capybara.server_host = '0.0.0.0'
      host! "http://#{Socket.gethostname}:#{Capybara.server_port}"
      super
    end
  end
else
  class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
    include Devise::Test::IntegrationHelpers
    driven_by :selenium, using: :headless_chrome, screen_size: [1280, 1024]
  end
end
