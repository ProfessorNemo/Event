# frozen_string_literal: true

module API
  class Base < ::Grape::API
    mount API::V1::Events
    mount API::V1::Users
  end
end
