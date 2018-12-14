module TrainSearches
  class CheckTicketsLogic
    include Singleton

    def search
      TrainSearch.unfulfilled.find_each do |train_search|
        FulfillTrainSearchLogic.new(train_search, browser).fulfill
      end

      # options = {
      #   body: {
      #     date: '2019-01-18',
      #     from: 22_00_001,
      #     to: 2_210_700,
      #     time: '00:00'
      #   }
      # }
      #
      # response = HTTParty.post('https://booking.uz.gov.ua/en/train_search/', options)
      # response
    end
  end
end
