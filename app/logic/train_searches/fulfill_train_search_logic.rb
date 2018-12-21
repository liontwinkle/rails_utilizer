module TrainSearches
  class FulfillTrainSearchLogic
    def initialize(train_search)
      @train_search = train_search
      @from_station = train_search.from_station
      @to_station = train_search.to_station
      @starting_from = train_search.start_search_from
      @date = train_search.uz_departure
      @train_number = train_search.uz_train_number
    end

    def fulfill
      save_seats
      # TODO: save seats if no train number provided
    end

    private

    def save_seats
      seats = train_by_number&.fetch('types')
      @train_search.first_seats_number = seats_number_by_class(seats, %w[L C1])
      @train_search.second_seats_number = seats_number_by_class(seats, %w[C C2])
      @train_search.third_seats_number = seats_number_by_class(seats, ['B'])
      @train_search.save!
    end

    def train_by_number
      available_trains.find { |train| train.fetch('num') =~ /#{@train_number}/ }
    end

    def available_trains
      uz_search_options = {
        body: {
          date: @date.to_s,
          from: @from_station,
          to: @to_station,
          time: @starting_from
        }
      }

      HTTParty.post('https://booking.uz.gov.ua/en/train_search/', uz_search_options)
        &.fetch('data')&.fetch('list')
    end

    def seats_number_by_class(seats, class_letters)
      seats.find { |it| class_letters.include?(it.fetch('letter')) }.fetch('places', 0)
    end
  end
end
