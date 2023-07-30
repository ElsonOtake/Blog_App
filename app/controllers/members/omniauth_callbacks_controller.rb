class Members::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    handle_auth 'Github'
  end

  def google_oauth2
    handle_auth 'Google'
  end

  def twitter2
    handle_auth 'Twitter'
  end

  def handle_auth(auth)
    @member = Member.from_omniauth(request.env['omniauth.auth'])

    if @member.persisted?
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: auth
      sign_in_and_redirect @member, event: :authentication
    else
      session['devise.auth_data'] = request.env['omniauth.auth'].except('extra')
      redirect_to new_member_registration_url, alert: @member.errors.full_messages.join("\n")
    end
  end
end
