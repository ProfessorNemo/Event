# frozen_string_literal: true

module API
  module V1
    class Users < ::API::Base
      helpers API::V1::Helpers::AuthenticationHelpers

      version 'v1', using: :path
      format :json
      content_type :json, 'application/json; charset=utf-8'
      prefix :api

      get 'status_count' do
        cookies[:status_count] ||= {
          value: 0,
          expires: Time.zone.now.tomorrow,
          domain: 'localhost:3000',
          path: "/api/#{version}/"
        }
        cookies[:status_count][:value] += 1
        { status_count: cookies[:status_count] }
      end

      delete 'status_count' do
        { status_count: cookies.delete(:status_count) }
      end

      resource :users do
        desc 'Return list of users with events'

        get do
          users = User.left_joins(:events)
                      .as_json(include: [{ events: { only: %i[title address datetime] } }])

          present users
        rescue ActiveRecord::RecordNotFound
          error!('Records not found', 404)
        end
      end
    end
  end
end
