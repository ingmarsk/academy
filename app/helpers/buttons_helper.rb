module ButtonsHelper
  def vote_button(voteable)
    return unless user_signed_in?

    voteable_class = voteable.class.name

    vote = Vote.find_by(voteable_type: voteable_class, voteable_id: voteable.id,
      user_id: current_user.id)

    if vote.present?
      link_to "Remove vote", vote_path(vote), method: :delete
    else
      button_to "Vote #{voteable_class.downcase}",
        votes_path(voteable_type: voteable_class, voteable_id: voteable.id)
    end
  end
end
