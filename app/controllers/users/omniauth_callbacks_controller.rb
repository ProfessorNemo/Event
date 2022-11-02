# frozen_string_literal: true

module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def vkontakte
      authenticate_user(:vkontakte)
    end

    def github
      authenticate_user(:github)
    end

    def google_oauth2
      authenticate_user(:google)
    end

    private

    def authenticate_user(provider)
      @user = User.find_for_oauth(provider, request.env['omniauth.auth'])

      if @user.nil?
        flash[:alert] =
          t('devise.omniauth_callbacks.failure', kind: provider, reason: t('devise.omniauth_callbacks.email_missing'))

        redirect_to new_user_session_path
      elsif @user.persisted?
        flash[:notice] = t('devise.omniauth_callbacks.success', kind: provider)

        sign_in_and_redirect @user, event: :authentication
      else
        flash[:alert] =
          t('devise.omniauth_callbacks.failure', kind: provider,
                                                 reason: t('devise.omniauth_callbacks.authentication_error'))

        redirect_to root_path
      end
    end
  end
end
