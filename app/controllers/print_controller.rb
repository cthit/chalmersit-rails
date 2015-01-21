class PrintController < ApplicationController
  include PrintHelper

  def new
      @print = Print.new(copies: 1)
      @print.username = current_user.uid if signed_in?
  end

  def print
    @print = Print.new(print_params)
    if @print.file.present?
      @print.file_name = @print.file.original_filename
      @print.file_cache = @print.file.tempfile.path
    end

    @print.file = File.new(@print.file_cache)

    @print.printer = Printer.find_by!(name: print_params[:printer])

    if @print.valid?
      begin
        print_script @print
        @print.printer.increment!(:weight)
        @print.file_cache = nil
        flash[:notice] = "Your document has been sent to the printer"
      rescue => e
        flash[:alert] = e.message
      end
    end
    render :new
  end

  private
    def print_params
      params.require(:print).permit(:username, :password, :copies, :printer, :file, :file_cache, :file_name, :duplex, :ranges, :media, :ppi)
    end
end
