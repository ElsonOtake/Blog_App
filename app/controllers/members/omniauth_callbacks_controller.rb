class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @member = Member.from_omniauth(request.env['omniauth.auth'])

    if @member.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Github'
      sign_in_and_redirect @member, event: :authentication
    else
      session['devise.github_data'] = request.env['omniauth.auth'].except('extra') # Removing extra as it can overflow some session stores
      redirect_to new_member_registration_url, alert: @member.errors.full_messages.join("\n")
    end
  end
end
