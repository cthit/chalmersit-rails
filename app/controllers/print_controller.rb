class PrintController < ApplicationController
  include PrintHelper

  def new
      @print = Print.new(copies: 1)
      @print.username = current_user.uid if signed_in?
  end

  def print
    @print = Print.new(print_params)

    # Solution for caching the uploaded file
    # Saved in file_cache and then sent to the client
    if @print.file.present?
      @print.file_name = @print.file.original_filename
      @print.file_cache = @print.file.tempfile.path
    end

    @print.file = File.new(@print.file_cache) if @print.file_cache

    @print.printer = Printer.find_by!(name: print_params[:printer])

    if @print.valid?
      begin
        print_script @print
        @print.printer.increment!(:weight)
        @print.file_cache = nil
        flash.now[:notice] = "Your document has been sent to the printer"
      rescue => e
        # Log error message to log/printer.log
        @print.print_logger e.message
        flash.now[:alert] = e.message
      end
    elsif @print.errors[:file].any?
      @print.file = nil
      @print.file_cache = nil
    end
    render :new
  end

  def pq
    render json: print_pq(params[:username], params[:password])
  end

  private
    def print_params
      params.require(:print).permit(:username, :password, :copies, :printer, :file, :file_cache, :file_name, :sides, :collate, :ranges, :media, :ppi)
    end
end
