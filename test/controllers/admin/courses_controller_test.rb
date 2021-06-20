require 'test_helper'

class Admin::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_user
    @course = create(:course)
  end

  test 'should get index' do
    get admin_courses_url
    assert_response :success
  end

  test 'should get new' do
    get new_admin_course_url
    assert_response :success
  end

  test 'should create course' do
    post admin_courses_url, params: valid_course_params
    assert_redirected_to admin_courses_path
  end

  test 'should show course' do
    get admin_course_url(@course)
    assert_response :success
  end

  test 'should get edit' do
    get edit_admin_course_url(@course)
    assert_response :success
  end

  test 'should update course' do
    patch admin_course_url(@course), params: valid_course_params
    assert_redirected_to admin_courses_url
  end

  test 'should destroy course' do
    delete admin_course_url(@course)
    assert_redirected_to admin_courses_url
  end

  private

  def valid_course_params
    {
      course: {
        title: Faker::Educator.course_name,
        description: Faker::Quote.matz
      }
    }
  end
end
