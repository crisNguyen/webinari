class WorkshopsController < ApplicationController
  def index
    @work_shops = Workshop.all
  end

  def show
    @workshop = Workshop.find(params[:id])
  end
end