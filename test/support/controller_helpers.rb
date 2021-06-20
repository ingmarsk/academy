class Support
  module ControllerHelpers
    def sign_in_user
      @user = create(:user)
      sign_in @user
    end
  end
end
