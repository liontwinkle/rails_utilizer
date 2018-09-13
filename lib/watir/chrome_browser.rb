module Watir
  module ChromeBrowser
    def in_browser
      browser = Watir::Browser.new :chrome, headless: true
      begin
        yield browser
      ensure
        browser.close
      end
    end
  end
end
