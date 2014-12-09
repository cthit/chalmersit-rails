class PrintController < ApplicationController
  include PrintHelper

  def new
      @print = Print.new(copies: 1)

  end

  def print
    # filepath = file.tempfile.path
    @print = Print.new(print_params)


    if @print.valid?
      begin
        print_script @print
        flash[:notice] = "Your document has been sent to the printer"
      rescue => e
        flash[:alert] = e.message
      end
    end
    render :new
  end

  private
    def print_params
      params.require(:print).permit(:username, :password, :file, :copies, :printer, :duplex, :ranges, :media, :ppi)
    end
end
