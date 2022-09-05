# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Event'
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
      base_title
    end
  end

  def bootstrap_class_for(flash_type)
    { success: 'alert-success', error: 'alert-danger', alert: 'alert-warning', notice: 'alert-info' }
      .stringify_keys[flash_type.to_s] || flash_type.to_s
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} my-3", role: 'alert')
      )
    end

    nil
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

  # для того, чтобыт при выборе локали не редиректило каждый раз на главную страницу
  def params_plus(additional_params)
    params.to_unsafe_h.merge(additional_params)
  end

  def language_bar
    I18n.locale.to_s == 'en' ? 'england' : 'ru'
  end
end
