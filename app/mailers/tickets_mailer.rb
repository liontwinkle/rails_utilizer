class TicketsMailer < ApplicationMailer
  def new_tickets_email
    @train_search = params[:train_search]
    mail(from: 'dgoul11@gmail.com', to: @train_search.email, subject: 'Новые билеты доступны: УЗ')
  end
end
