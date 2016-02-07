class ContactController < ApplicationController

def index 
   @contact = Contact.new
end

def create 
   if params[:value].blank? then
      contact_params = params[:contact]
      mail_array = contact_params[:to_whom] << contact_params[:email]

      GroupMailer.anonymous_mail(mail_array, contact_params[:body], contact_params[:title]).deliver_now
   end

   redirect_to :contact_index
end

def new
   @contact = Contact.new
end

def show
end


end
