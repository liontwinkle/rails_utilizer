module Watir
  class ChromeBrowser
    def self.in_browser
      browser_options = { headless: true }

      # set chrome path for heroku
      if (chrome_bin = ENV.fetch('GOOGLE_CHROME_SHIM', nil))
        browser_options[:options] = { binary: chrome_bin }
      end
      browser_options[:switches] = %w[--disable-dev-shm-usage --no-sandbox --ignore-certificate-errors --disable-popup-blocking --disable-translate --disable-notifications --start-maximized --disable-gpu --headless]
      browser = Watir::Browser.new :chrome, browser_options
      begin
        yield browser
      ensure
        browser.close
      end
    end
  end
end
