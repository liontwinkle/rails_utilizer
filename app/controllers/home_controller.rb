class HomeController < ApplicationController
  def index
    # browser = Watir::Browser.new :chrome, headless: true
    # begin
    #   browser.goto 'https://booking.uz.gov.ua/?from=2204001&to=2200001&date=2018-09-13&time=00%3A00&url=train-list'
    #   train_row = browser.div(css: '.num div', visible_text: /\.*723\.*/).wait_until(&:present?).parent.wait_until(&:present?).parent.wait_until(&:present?)
    #
    #   @places_by_class = train_row.spans(css: '.place .item .place-count')
    #   @first_class = @places_by_class[0].text
    #   @second_class = @places_by_class[1].text
    #   @third_class = @places_by_class[2].text if @places_by_class.length > 2
    #
    # ensure
    #   browser.close
    # end
  end
end
