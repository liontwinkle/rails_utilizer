class TrainSearch < ApplicationRecord
  validates :uz_train_number, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :unfulfilled, -> { where('uz_departure > ?', Time.current.end_of_day) }

  before_save :init_from_url, on: :create
  after_save :notify_user, if: :new_seats_available?

  private

  # e.g. url => https://booking.uz.gov.ua/?from=2204001&to=2200001&date=2018-09-13&time=00%3A00&url=train-list
  # departure = 2018-09-13
  # from_station = 220400
  # start_search_from= 00:00
  def init_from_url
    attributes_from_url = Uz::UrlParserLogic.new(uz_search_url).attributes
    self.assign_attributes = attributes_from_url
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
    TicketsMailer.with(train_search: self).new_tickets_email.deliver_later
  end
end
