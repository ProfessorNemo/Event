# frozen_string_literal: true

module API
  module V1
    module Helpers
      module AuthenticationHelpers
        extend Grape::API::Helpers

        # def random_user
        #   User.order(Arel.sql('Random()')).first
        # end

        def warden
          env['warden']
        end

        def authenticated
          return true if warden.authenticated?

          params[:access_token] && (@user = User.find_by(authentication_token: params[:access_token]))
        end

        # def authenticated
        #   user = User.find_by_email(params[:email])
        #   user && user.valid_password?(params[:password])
        # end

        def current_user
          warden.user || @user
        end

        def user_info
          "#{current_user} has named #{current_user.name}"
        end
      end
    end
  end
end
