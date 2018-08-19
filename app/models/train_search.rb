class TrainSearch < ApplicationRecord
  belongs_to :user

  validates :uz_train_number, :user, presence: true

  before_save :init_departure_from_url, on: :create, unless: :uz_departure

  accepts_nested_attributes_for :user

  private

  # e.g. url => https://booking.uz.gov.ua/?from=2204001&to=2200001&date=2018-09-13&time=00%3A00&url=train-list
  # departure = 2018-09-13
  def init_departure_from_url
    date_format_in_url = /date=(\d+-\d+-\d+)/
    departure_as_string = uz_search_url.match(date_format_in_url)&.captures&.first
    self.uz_departure = departure_as_string.in_time_zone
  end
end
