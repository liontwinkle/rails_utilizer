module Uz
  class UrlParserLogic
    DATE_FORMAT = /date=(\d+-\d+-\d+)/
    FROM_STATION_FORMAT = /from=(\d+)&/
    TO_STATION_FORMAT = /to=(\d+)&/
    START_TIME_FORMAT = /time=(\d\d:\d\d)/

    def initialize(url)
      @url = CGI.unescape(url)
    end

    def attributes
      {
        uz_departure: date,
        from_station: from_station,
        to_station: to_station,
        start_search_from: start_time
      }
    end

    private

    def date
      parse_url_for(DATE_FORMAT).in_time_zone
    end

    def from_station
      parse_url_for(FROM_STATION_FORMAT)
    end

    def to_station
      parse_url_for(TO_STATION_FORMAT)
    end

    def start_time
      parse_url_for(START_TIME_FORMAT)
    end

    def parse_url_for(format)
      @url.match(format)&.captures&.first
    end
  end
end
