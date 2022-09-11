# frozen_string_literal: true

module PhotoHelper
  def user_avatar(user)
    user&.avatar&.url || asset_path('user.png')
  end

  def user_avatar_thumb(user)
    if user&.avatar&.file.present?
      user.avatar.thumb.url
    else
      asset_path('user.png')
    end
  end

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

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end
end
