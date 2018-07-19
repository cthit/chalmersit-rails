class ContactController < ApplicationController
  layout 'bare', only: [:index, :show]


  def index
     @contact = Contact.new
  end

  def create
      contact_params = params[:contact]
      if !contact_params[:body].blank? and check_addresses?(contact_params[:to_whom])
          mail_array = contact_params[:to_whom] << contact_params[:email]

          GroupMailer.anonymous_mail(mail_array, contact_params[:body], contact_params[:title]).deliver_now
          redirect_to :contact_index, flash: {notice: I18n.translate('mail_sent', recipents: build_contacts_string(contact_params[:to_whom]))}
      else
          redirect_to :contact_index, flash: {error: I18n.translate('mail_error')}
      end
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

    def check_addresses?(to_whom)
        !to_whom.blank? and to_whom.all? {|to| Contact.available_mails.include?(to) or to.empty?}
    end
end
