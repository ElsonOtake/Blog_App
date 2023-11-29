class Members::RegistrationsController < Devise::RegistrationsController
  after_action :after_signup, only: %i[ create ]

  def after_signup
    current_visitor && current_visitor.update!(member: current_user)
  end
end