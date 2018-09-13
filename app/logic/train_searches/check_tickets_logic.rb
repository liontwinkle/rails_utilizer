module TrainSearches
  class CheckTicketsLogic
    include Singleton

    def search
      Watir::ChromeBrowser.in_browser do |browser|
        fulfill_train_searches(browser)
      end
    end

    private

    def fulfill_train_searches(browser)
      TrainSearch.unfulfilled.find_each do |train_search|
        # is not loaded because of namespace. uninitialized constant TrainSearches::CheckTicketsLogic::FulfillTrainSearch≥
        FulfillTrainSearch.new(train_search, browser).fulfill
      end
    end
  end
end
