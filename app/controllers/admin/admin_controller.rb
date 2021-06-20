class Admin::AdminController < ActionController::Base
  include ControllerHelpers

  before_action :authenticate_user!

  layout 'admin'
end
