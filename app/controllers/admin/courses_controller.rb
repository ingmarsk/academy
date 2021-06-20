class Admin::CoursesController < Admin::AdminController
  before_action :load_course, only: %i(show edit update destroy)

  def index
    @courses = Finders::Course.new(params.merge(user_id: current_user.id)).call
  end

  def show
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      register_course_to_user
      redirect_to admin_courses_path, notice: 'Course successfully created.'
    else
      render :new
    end
  end

  def update
    if @course.update(course_params)
      redirect_to admin_courses_path, notice: 'Course successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_courses_path, notice: 'Course successfully deleted.'
  end

  private

  def load_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description)
  end

  def register_course_to_user
    current_user.courses << @course
  end
end
