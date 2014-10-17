class SheetsController < ApplicationController
  before_action :set_sheet, only: [:show]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]
  respond_to :html

  def index
    @sheets = Sheet.all.order("created_at DESC")
    respond_with(@sheets)
  end

  def show
    respond_with(@sheet)
  end

  def new
    @sheet = current_user.sheets.build
    respond_with(@sheet)
  end

  def edit
  end

  def create
    @sheet = current_user.sheets.build(sheet_params)
    @sheet.save
    respond_with(@sheet)
  end

  def update
    @sheet.update(sheet_params)
    respond_with(@sheet)
  end

  def destroy
    @sheet.destroy
    respond_with(@sheet)
  end

  private
    def set_sheet
      @sheet = Sheet.find(params[:id])
    end

    def correct_user
      @sheet = current_user.sheets.find_by!(params[:id])
      redirect_to sheets_path, notice: "Not authorized to edit this sheet." if @sheet.nil?
    end

    def sheet_params
      params.require(:sheet).permit(:description, :image)
    end
end
