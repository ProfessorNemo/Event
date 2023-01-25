# frozen_string_literal: true

module API
  module V1
    module Helpers
      module AuthenticationHelpers
        extend Grape::API::Helpers

        def current_user
          User.order(Arel.sql('Random()')).first
        end

        def unauthorized
          401
        end

        def user_info(user)
          "#{user} has named #{user.name}"
        end
      end
    end
  end
end
