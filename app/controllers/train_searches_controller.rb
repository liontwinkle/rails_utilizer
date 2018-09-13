class TrainSearchesController < ApplicationController
  def new
    @train_search = TrainSearch.new
  end

  def create
    @train_search = TrainSearch.new(create_params)
    if @train_search.save
      flash[:notice] = 'Спасибо за запрос. Вы получите уведомления о новых билетах'
      redirect_to :root
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:train_search).permit(:uz_train_number, :uz_search_url, :email)
  end
end
