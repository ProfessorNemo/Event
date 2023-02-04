# frozen_string_literal: true

Rails.application.config.middleware.use Warden::Manager do |manager|
  manager.default_strategies :password
end

Warden::Manager.serialize_into_session(&:id)

Warden::Manager.serialize_from_session do |id|
  User.find(id)
end

Warden::Strategies.add(:password) do
  def authenticate!
    user = User.find_by(email: params['email'])
    raise 'Invalid email or password' unless user&.authenticate(params['password'])

    success! user
  end
end
