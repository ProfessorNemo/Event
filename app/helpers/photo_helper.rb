# frozen_string_literal: true

module PhotoHelper
  # Если у пользователя есть собственный аватар, то показываем его,
  # иначе — стандартную иконку.
  def user_avatar(user)
    user&.avatar&.url || asset_path('user.png')
  end

  # метод, который выводит миниатюрную версию аватарки:
  def user_avatar_thumb(user)
    if user&.avatar&.file.present?
      user.avatar.thumb.url
    else
      asset_path('user.png')
    end
  end

  # Возвращает адрес рандомной фотки события, если есть хотя бы одна
  # Или ссылку на картинку по умолчанию
  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_path('bg.jpg')
    end
  end

  def oauth_logo(provider)
    asset_path("#{provider}.png")
  end

  # Возвращает миниатюрную версию фотки
  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end
end
