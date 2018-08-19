class TrainSearchesController < ApplicationController
  def new
    @train_search = TrainSearch.new(user: User.new)
    @train_search.build_user
  end

  def create
    # binding.pry
    train_search = TrainSearch.new(create_params)
    # TODO:
      # 1-save train search
      # 2-render new with notice
      # 3-save or find user
  end

  private

  def create_params
    params.require(:train_search).permit(:uz_train_number, :uz_search_url, user_attributes: [:email])
  end
end
