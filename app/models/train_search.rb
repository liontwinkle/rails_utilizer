class TrainSearch < ApplicationRecord
  validates :uz_train_number, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :unfulfilled, -> { where('uz_departure > ?', Time.current.end_of_day) }

  before_save :init_departure_from_url, on: :create, unless: :uz_departure
  after_save :notify_user, if: :new_seats_available?

  private

  # e.g. url => https://booking.uz.gov.ua/?from=2204001&to=2200001&date=2018-09-13&time=00%3A00&url=train-list
  # departure = 2018-09-13
  def init_departure_from_url
    date_format_in_url = /date=(\d+-\d+-\d+)/
    departure_as_string = uz_search_url.match(date_format_in_url)&.captures&.first
    self.uz_departure = departure_as_string.in_time_zone
  end

  def new_seats_available?
    change_to_seat_number('first')    ||
      change_to_seat_number('second') ||
      change_to_seat_number('third')
  end

  def change_to_seat_number(seats_type)
    old_new_numbers = send("saved_change_to_#{seats_type}_seats_number")
    old_new_numbers&.first && old_new_numbers.first < old_new_numbers.last
  end

  def notify_user
    Rails.logger.fatal "NEW PLACES FOUND FOR #{id}"
    # TODO: Send notification email/or message with new number of seats
  end
end
