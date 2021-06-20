module ControllerHelpers
  extend ActiveSupport::Concern

  included do
    def load_voteable
      case params[:voteable_type]
      when 'Course'
        @voteable = Course.find(params[:voteable_id])
      when 'User'
        @voteable = User.find(params[:voteable_id])
      end
    end
  end
end
