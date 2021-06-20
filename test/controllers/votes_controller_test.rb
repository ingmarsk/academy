require 'test_helper'

class Admin::VotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in_user
    @course = create(:course)
    @another_user = create(:user)
  end

  test 'should vote a course' do
    assert_difference 'Vote.count', 1 do
      post votes_url, params: valid_vote_params(@course)
      assert_redirected_to admin_courses_url
      assert_equal 1, @course.votes.size
    end
  end

  test 'should un-vote a course' do
    @vote = Vote.create(valid_vote_params(@course).merge(user_id: @user.id))

    assert_difference 'Vote.count', -1 do
      delete vote_url(@vote)
      assert_redirected_to admin_courses_url
      assert_equal 0, @course.votes.size
    end
  end

  test 'should vote another user' do
    assert_difference 'Vote.count', 1 do
      post votes_url, params: valid_vote_params(@another_user)
      assert_redirected_to admin_courses_url
      assert_equal 1, @another_user.votes.size
    end
  end

  test 'should un-vote another user' do
    @vote = Vote.create(valid_vote_params(@another_user).merge(user_id: @user.id))

    assert_difference 'Vote.count', -1 do
      delete vote_url(@vote)
      assert_redirected_to admin_courses_url
      assert_equal 0, @another_user.votes.size
    end
  end

  test 'should user vote himself' do
    assert_difference 'Vote.count', 1 do
      post votes_url, params: valid_vote_params(@user)
      assert_redirected_to admin_courses_url
      assert_equal 1, @user.votes.size
    end
  end

  test 'should user un-vote himself' do
    @vote = Vote.create(valid_vote_params(@user).merge(user_id: @user.id))

    assert_difference 'Vote.count', -1 do
      delete vote_url(@vote)
      assert_redirected_to admin_courses_url
      assert_equal 0, @user.votes.size
    end
  end

  private

  def valid_vote_params(voteable)
    { voteable_type: voteable.class.name, voteable_id: voteable.id }
  end
end
