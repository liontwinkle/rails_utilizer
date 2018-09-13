class FulfillTrainSearch
  def initialize(train_search, browser)
    @train_search = train_search
    @browser = browser
  end

  def fulfill
    train_watir_row = find_train_watir_row
    available_seats = find_available_seats_on_train(train_watir_row)
    @train_search.update!(available_seats)
  end

  private

  def find_train_watir_row
    @browser.goto(@train_search.uz_search_url)
    @browser.div(css: '.num div', visible_text: train_number_regexp)
            .wait_until(&:present?).parent
            .wait_until(&:present?).parent
            .wait_until(&:present?)
  end

  def train_number_regexp
    # any number of any character
    # then train number
    # followed by any number of any characters
    Regexp.new("\\.*#{@train_search.uz_train_number}\\.*")
  end

  def find_available_seats_on_train(train_watir_row)
    seats_by_class = train_watir_row.spans(css: '.place .item .place-count')
    {
      first_seats_number: seats_by_class.fetch(0).text,
      second_seats_number: seats_by_class.fetch(1).text,
      third_seats_number: seats_by_class.fetch(2, nil)&.text
    }
  end
end
