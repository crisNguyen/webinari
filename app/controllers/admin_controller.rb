class AdminController < applicationController
  before_action :authenticate_admin_user!
end