module TrainSearches
  class CheckTicketsLogic
    include Singleton

    def search
      threads = []
      TrainSearch.unfulfilled.find_each do |train_search|
        threads << Thread.new do
          FulfillTrainSearchLogic.new(train_search).fulfill
        end
      end
      threads.each(&:join)
    end
  end
end
