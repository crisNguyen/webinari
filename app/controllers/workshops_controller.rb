class WorkshopsController < ApplicationController
  def index
    @work_shops = Workshop.upcoming_workshops
  end

  def show
    @workshop = Workshop.friendly.find(params[:id])
  end
end