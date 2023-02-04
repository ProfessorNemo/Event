# frozen_string_literal: true

module API
  module V1
    class Events < ::API::Base
      helpers API::V1::Helpers::AuthenticationHelpers

      before do
        error!('Unauthorized. Invalid token.', 401) unless authenticated
      end

      get 'info' do
        user_info
      end

      resource :events do
        desc 'Return list of events' do
          detail 'View all users and their events'
        end

        before do
          header['Access-Control-Request-Method'] = 'GET'
        end

        get do
          events = Event.joins(:user)
                        .where('datetime >= ?', Time.zone.now)
                        .select(:title, :address, :datetime, :user_id)
                        .as_json(include: [{ user: { only: %i[id name email avatar] } }])

          events.map! { |hash| hash.delete_if { |k, _v| k == 'id' } }

          present events
        rescue ActiveRecord::RecordNotFound
          error!('Records not found', 404)
        end
      end

      namespace :user do
        before do
          header['Access-Control-Request-Method'] = 'POST'
        end

        params do
          requires :title, type: String
          optional :description, type: String, allow_blank: true
          requires :address, type: String
          requires :datetime, type: Date
          requires :pincode, type: String, default: -> { Random.rand(100..10_000).to_s }
          requires :notifications, type: Boolean, default: false
          optional :snapshot, type: String, allow_blank: true
          requires :user_id, type: Integer, allow_blank: false
          requires :user, type: Hash do
            requires :name, type: String
            optional :email, type: String
          end
        end

        desc 'Create a new event'
        post 'events' do
          Event.create! title: params[:title], address: params[:address],
                        datetime: params[:datetime], pincode: params[:pincode],
                        notifications: params[:notifications], user_id: params[:user_id]

          { 'event_new' => declared(params, include_missing: true) }
        end

        resource :event do
          before do
            header['Access-Control-Request-Method'] = 'PUT'
          end

          desc 'Update a specific event'
          route_param :id, type: Integer do
            put do
              id_event = Event.order(created_at: :desc).first.id

              error! :not_found, 404 unless params['id'] == id_event

              event = Event.find_by(id: params['id'])
              event.update({ title: params['title'] })
              event.reload
              { status: 'OK', message: 'Record updated successfully',
                event: event.attributes }
            end
          end
        end

        resource :event do
          before do
            header['Access-Control-Request-Method'] = 'DELETE'
          end

          desc 'Delete a specific event'
          route_param :id, type: Integer do
            delete do
              id_event = Event.find_by(id: params[:id]).id

              error! :not_found, 404 unless params['id'] == id_event

              event = Event.find_by(id: params['id'])
              event.destroy

              { status: 'OK', message: 'Event deleted' }
            end
          end
        end
      end

      resource :events do
        before do
          header['Access-Control-Request-Method'] = 'GET'
        end

        desc 'Return a specific event'
        route_param :id, type: Integer do
          get do
            event = Event.find_by(id: params[:id]).attributes

            present event
          rescue ActiveRecord::RecordNotFound
            error!('Record nor found', 404)
          end
        end
      end
    end
  end
end
