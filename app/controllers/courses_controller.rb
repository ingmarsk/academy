class CoursesController < ApplicationController
  before_action :load_course, only: :show

  def index
    @courses = Finders::Course.new(params).call
  end

  def show
  end

  private

  def load_course
    @course = Course.find(params[:id])
  end
end
