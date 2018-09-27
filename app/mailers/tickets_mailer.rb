class TicketsMailer < ApplicationMailer
  def new_tickets_email
    @train_search = params[:train_search]
    mail(from: 'uz_notifier@noreply.com', to: @train_search.email, subject: 'Welcome to My Awesome Site')
  end
end
