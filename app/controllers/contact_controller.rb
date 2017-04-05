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

      redirect_to :contact_index, flash: {notice: I18n.translate('mail_sent', recipents: build_contacts_string(contact_params[:to_whom]))}
  end

  def new
     @contact = Contact.new
  end

  def show
  end
  private
    def build_contacts_string(contacts_arr)
        contacts_arr.delete("")
        if(contacts_arr.size <= 1)
            return_string = contacts_arr.first
        else
            return_string = contacts_arr.first(contacts_arr.size - 1).join(', ') + I18n.translate('and') + contacts_arr.last
        end
        return_string.gsub("@chalmers.it","")
    end
end
