class ContactController < ApplicationController
  layout 'bare', only: [:index, :show]


  def index
     @contact = Contact.new
  end

  def create
      contact_params = params[:contact]
      if params[:value].blank? && !contact_params[:to_whom].blank? && Contact.available_mails.include?(contact_params[:to_whom].first)
        mail_array = contact_params[:to_whom] << contact_params[:email]
        GroupMailer.anonymous_mail(mail_array, contact_params[:body], contact_params[:title]).deliver_now
      end

      redirect_to :contact_index, flash: {notice: "your mail has been sent to " + contact_params[:to_whom].first}
  end

  def new
     @contact = Contact.new
  end

  def show
  end

end
