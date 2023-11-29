class Members::SessionsController < Devise::SessionsController
  after_action :after_login, only: %i[create]

  def after_login
    current_visitor&.update!(member: current_user)
  end
end
