# frozen_string_literal: true

module ApplicationHelper
  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }
      .stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages(_opts = {})
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} my-3", role: 'alert') do
          concat content_tag(:button, nil, class: 'btn-close float-end', type: 'button',
                                           data: { 'bs-dismiss' => 'alert' }, 'aria-label' => 'Close')
          concat message
        end
      )
    end

    nil
  end

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

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_path('event_thumb.jpg')
    end
  end

  def flash_class_name(name)
    case name
    when 'notice' then 'success'
    when 'alert'  then 'danger'
    else name
    end
  end

  def fa_icon(icon)
    content_tag 'span', '', class: "fa fa-#{icon[:class]}", style: "color: #{icon[:color]};"
  end

  def oauth_logo(provider)
    asset_path("#{provider}.png")
  end
end
