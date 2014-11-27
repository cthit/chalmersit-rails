class PrintController < ApplicationController
  include PrintHelper

  def new
      
  end

  def print
    user = params[:username]
    pass = params[:password]
    file = params[:file]
    printer = params[:printer]
    copies = params[:copies]
    options = params[:options]

    filepath = file.tempfile.path

    begin
      print_script user, pass, filepath, printer, copies
      flash[:notice] = "Your document has been sent to the printer"
    rescue => e
      flash[:alert] = e.message
    end
    render :new
  end
end
