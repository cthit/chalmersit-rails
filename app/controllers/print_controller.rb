class PrintController < ApplicationController
  include PrintHelper

  def new
      @print = Print.new(copies: 1)

  end

  def print
    printer = Printer.find_by!(name: print_params[:printer])

    new_print_params = print_params.merge(printer: printer)
    # filepath = file.tempfile.path
    @print = Print.new(new_print_params)



    if @print.valid?
      begin
        # print_script @print
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
