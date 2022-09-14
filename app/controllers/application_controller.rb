# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Internationalization
  include ErrorHandling
  include ActionView::RecordIdentifier

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  # Настройка для работы девайза при правке профиля юзера
  # "if: :devise_controller?" - true, если выполняется девайсовский контроллер
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Хелпер метод, доступный во вьюхах
  helper_method :current_user_can_edit?

  # Настройка для девайза — разрешаем обновлять профиль, но обрезаем
  # параметры, связанные со сменой пароля.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: %i[password password_confirmation current_password]
    )
  end

  # Вспомогательный метод, возвращает true, если текущий залогиненный юзер
  # может править указанное событие
  def current_user_can_edit?(model)
    # Если у модели есть юзер и он залогиненный, пробуем у модели взять .event и
    # если он есть, проверяем его юзера на равенство current_user.
    user_signed_in? && (
      model.user == current_user ||
      (model.try(:event).present? && model.event.user == current_user)
    )
  end
end

# model.try(:event) - вызвать у объекта model метод, который передали в качестве символа.
# Если этого метода нет у объекта, то try вернет nil.
