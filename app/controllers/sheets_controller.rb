class SheetsController < ApplicationController
  before_action :set_sheet, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @sheets = Sheet.all
    respond_with(@sheets)
  end

  def show
    respond_with(@sheet)
  end

  def new
    @sheet = Sheet.new
    respond_with(@sheet)
  end

  def edit
  end

  def create
    @sheet = Sheet.new(sheet_params)
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

    def sheet_params
      params.require(:sheet).permit(:description, :string)
    end
end
