class HomeController < ApplicationController
  def index
    @upcoming_workshops = Workshop.upcomming_workshops
    @past_workshops = Workshop.past_workshops
  end
end
