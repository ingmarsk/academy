class VotesController < ApplicationController
  before_action :load_voteable, only: :create
  before_action :load_vote, only: :destroy

  def create
    Vote.create(voteable: @voteable, user_id: current_user.id)
    redirect_to admin_courses_path, notice: "#{@voteable.class.name} voted."
  end

  def destroy
    @vote.destroy
    redirect_to admin_courses_path, notice: "#{@vote.voteable.class.name} unvoted."
  end

  private

  def load_vote
    @vote ||= Vote.find(params[:id])
  end
end
