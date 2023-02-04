# frozen_string_literal: true

module API
  class Base < Grape::API
    version 'v1', using: :path, vendor: 'event_app'
    format :json
    content_type :json, 'application/json; charset=utf-8'
    prefix :api

    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Allow-Methods'] = %w[GET POST PUT DELETE].join(', ')
      header['Date'] = Time.zone.now
    end

    mount API::V1::Events
    mount API::V1::Users

    add_swagger_documentation(
      info: {
        title: 'API-Events',
        description: 'API contains information about users and events',
        contact_name: 'Professor Moriarty',
        contact_email: 'gleboceanborn@gmail.com',
        contact_url: 'https://github.com/ProfessorNemo'
      },
      api_version: 'v1',
      hide_documentation_path: true,
      hide_format: true,
      host: 'localhost:3000',
      mount_path: '/documentation',
      add_version: true,
      doc_version: '0.0.1',
      token_owner: 'resource_owner',
      security_definitions: {
        api_key: {
          type: 'apiKey',
          name: 'access_token',
          in: 'params'
        }
      }
    )
  end
end
