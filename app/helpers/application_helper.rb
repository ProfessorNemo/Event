# frozen_string_literal: true

module ApplicationHelper
  # Возвращает путь к аватарке данного юзера
  def user_avatar(_user)
    asset_path('user.png')
  end
end
